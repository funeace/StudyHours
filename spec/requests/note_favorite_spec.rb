require 'rails_helper'

  # インスタンス変数
  # viewの表示が正しいか
  # postでやるときは paramsで飛ばす
  # ユーザ認証

  # http_status 200 成功 非同期のためレスポンスは200(xhr:true)
  # 302 リダイレクト

describe NoteFavoritesController, type: :request do
  let!(:user){ create(:user) }
  let!(:note){ create(:note) }
  before do
    sign_in user
  end
  describe "POST #create" do
    context "パラメータが正しい場合" do
      it "リクエストは正しいか" do
        post note_note_favorites_path(note_id: note.id),
          params: {note_favorite: FactoryBot.attributes_for(:note_favorite)},
            xhr: true
        # binding.pry
        expect(response).to have_http_status(200)
      end
      it "投稿は成功するか" do
        expect do
          post note_note_favorites_path(note_id: note.id),
            params: {note_favorite: FactoryBot.attributes_for(:note_favorite)},
              xhr: true
        end.to change(NoteFavorite, :count).by(1)
      end
    end
    context "パラメータが正しくない場合" do
      it "リクエストは正しいか" do
        post note_note_favorites_path(note_id: note.id),
          params: {note_favorite: FactoryBot.attributes_for(:note_favorite,user_id: "")},
            xhr: true
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:note_favorite){ NoteFavorite.create(user_id: user.id,note_id: note.id) }
    it "リクエストが正しいか" do
      delete note_note_favorites_path(note_id: note.id),
        params: {user_id: user.id,note_id: note.id},
          xhr: true
      expect(response).to have_http_status(200)
    end
    it "削除は成功するか" do
      expect do
        delete note_note_favorites_path(note_id: note.id),
          params: {user_id: user.id,note_id: note.id},
            xhr: true
      end.to change(NoteFavorite, :count).by(-1)
    end
  end
end
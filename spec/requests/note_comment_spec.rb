require 'rails_helper'

  # インスタンス変数
  # viewの表示が正しいか
  # postでやるときは paramsで飛ばす
  # ユーザ認証

  # http_status 200 成功 非同期のためレスポンスは200(xhr:true)
  # 302 リダイレクト

describe NoteCommentsController, type: :request do
  let!(:user){ create(:user) }
  let!(:note){ create(:note) }
  before do
    sign_in user
  end
  describe "POST #create" do
    context "パラメータが正しい時" do
      it "リクエストが成功するか" do
        post note_note_comments_path(note_id: note.id),
          params: { note_comment: FactoryBot.attributes_for(:note_comment) },
            xhr: true
        # binding.pry
        expect(response).to have_http_status(200)
      end
      it "投稿が成功するか" do
        expect do
          post note_note_comments_path(note_id: note.id),
            params: { note_comment: FactoryBot.attributes_for(:note_comment) },
              xhr: true
        end.to change(NoteComment, :count).by(1)
      end
    end
    context "パラメータが正しくない時" do
      it "リクエストが成功するか" do
        post note_note_comments_path(note_id: note.id),
          params: { note_comment: FactoryBot.attributes_for(:note_comment,comment:"") },
            xhr: true
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:note_comment) { create(:note_comment) }
    it "リクエストが成功するか" do
      delete note_note_comment_path(note_comment,note_id: note.id),
        params: { note_comment: FactoryBot.attributes_for(:note_comment) },
          xhr: true
      expect(response).to have_http_status(200)
    end
    it "削除が成功するか" do
      expect do
        delete note_note_comment_path(note_comment,note_id: note.id),
          params: { note_comment: FactoryBot.attributes_for(:note_comment) },
            xhr: true
      end.to change(NoteComment, :count).by(-1)
    end
  end
end
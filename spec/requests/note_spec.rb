require 'rails_helper'

  # インスタンス変数
  # viewの表示が正しいか
  # postでやるときは paramsで飛ばす
  # ユーザ認証

  # http_status 200 成功
  # 302 リダイレクト

describe NotesController, type: :request do
  describe "GET #new" do
    context "ログインしている場合" do
      let!(:user){create(:user)}
      before do
        sign_in user
      end
      it "リクエストは成功するか" do
        get new_note_path
        expect(response).to have_http_status(200)
      end
    end
    context "ログインしていない場合" do
      it "リダイレクトが発生するか" do
        get new_note_path
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "POST #create" do
    let!(:user){ create(:user) }
    before do
      sign_in user
    end
    context "パラメータが正しい場合" do
      it "リクエストは成功するか" do
        post notes_path, params: { user_id: user.id,note: FactoryBot.attributes_for(:note) }
        expect(response).to have_http_status(302)
      end
      it "投稿は成功するか" do
        expect do
          post notes_path, params: { user_id: user.id,note: FactoryBot.attributes_for(:note) }
        end.to change(Note, :count).by(1)
      end
      it "リダイレクト先は正しいか" do
        post notes_path, params: { user_id: user.id,note: FactoryBot.attributes_for(:note) }
        expect(response).to redirect_to note_path(Note.last)
      end
    end
    context "パラメータが不正な場合" do
      it "リクエストは成功するか" do
        post notes_path, params: { user_id: user.id,note: FactoryBot.attributes_for(:note,title:"") }
        expect(response).to have_http_status(200)
      end
      it "投稿に失敗するか" do
        expect do
          post notes_path, params: { user_id: user.id,note: FactoryBot.attributes_for(:note,title:"") }
        end.not_to change(Note, :count)
      end
    end
  end

  describe "GET #show" do
    let!(:user){ create(:user) }
    let!(:note){ create(:note) }
    let!(:note_comment){ build(:note_comment) }
    it "リクエストは成功するか" do
      get note_path(note)
      expect(response).to have_http_status(200)
    end
    it "titleは表示されるか" do
      get note_path(note)
      expect(response.body).to include "noteテスト"
    end
    it "コメントが表示されているか" do
      note_comment.note_id = note.id
      note_comment.user_id = user.id
      note_comment.save
      get note_path(note)
      expect(response.body).to include "てすてすてすてす"
    end
  end

  describe "GET #edit" do
    let!(:user){ create(:user) }
    let!(:note){ create(:note,user_id: user.id) }
    context "ログイン済みの場合" do
      before do
        sign_in user
      end
      it "リクエストは成功するか" do
        get edit_note_path(note)
        expect(response).to have_http_status(200)
      end
      it "titleは表示されるか" do
        get edit_note_path(note)
        expect(response.body).to include "noteテスト" 
      end
    end
    context "ログインしていない場合" do
      it "リダイレクトされるか" do
        get edit_note_path(note)
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "PATCH #update" do
    let!(:user){create(:user)}
    let!(:note){create(:note)}
    before do
      sign_in user
    end
    context "パラメータが正しい場合" do
      it "リクエストは成功するか" do
        patch note_path(note),params:{note:FactoryBot.attributes_for(:note,title:"てすてすてすてす")}
        expect(response).to have_http_status(302)
      end
      it "更新は成功するか" do
        expect do
          patch note_path(note),params:{note:FactoryBot.attributes_for(:note,title:"てすてすてすてす")}
        end.to change{Note.find(note.id).title}.from("noteテスト").to("てすてすてすてす")
      end
      it "リダイレクトされるか" do
        patch note_path(note),params:{note:FactoryBot.attributes_for(:note,title:"てすてすてすてす")}
        expect(response).to redirect_to note_path(note.id)
      end
    end
    context "パラメータが不正な場合" do
      it "リクエストは成功するか" do
          patch note_path(note),params:{note:FactoryBot.attributes_for(:note,title:"")}
          expect(response).to have_http_status(200)
      end        
      it "更新に失敗するか" do
        expect do
          patch note_path(note),params:{note:FactoryBot.attributes_for(:note,title:"")}
        end.not_to change{Note.find(note.id)}
      end        
    end
  end

  describe "DELETE #destroy" do
    let!(:user){create(:user)}
    let!(:note){create(:note)}
    before do
      sign_in user
    end
    it "リクエストは成功するか" do
      delete note_path(note)
      expect(response).to have_http_status(302)
    end
    it "削除されるか" do
      expect do
        delete note_path(note)
      end.to change(Note,:count).by(-1)
    end
    it "リダイレクトされるか" do
      delete note_path(note)
      expect(response).to redirect_to timelines_path
    end
  end
end
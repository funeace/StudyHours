require 'rails_helper'

  # インスタンス変数
  # viewの表示が正しいか
  # postでやるときは paramsで飛ばす
  # ユーザ認証

  # http_status 200 成功 非同期のためレスポンスは200(xhr:true)
  # 302 リダイレクト

RSpec.describe Admins::NotesController, type: :request do
  describe "get #index" do
    let!(:admin){ create(:admin) }
    let!(:note){ create(:note) }
    context "ログインしているとき" do
      before do
        sign_in admin
      end
      it "リクエストが成功するか" do
        get admins_notes_path
        expect(response).to have_http_status(200)
      end
      it "投稿されたノートが表示されているか" do
        get admins_notes_path
        expect(response.body).to include "noteテスト"
      end
    end

    context "ログインしていないとき" do
      it "リダイレクトされるか" do
        get admins_notes_path
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "get #show" do
    let!(:admin){ create(:admin) }
    let!(:note){ create(:note) }
    context "ログインしているとき" do
      before do
        sign_in admin
      end
      it "リクエストが成功するか" do
        get admins_note_path(note)
        expect(response).to have_http_status(200)
      end
      it "ノートは表示されているか" do
        get admins_note_path(note)
        expect(response.body).to include "テストテストテストテストテストテストテストテストテスト"
      end
    end

    context "ログインしていないとき" do
      it "リダイレクトされるか" do
        get admins_note_path(note)
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "delete #destroy" do
    let!(:admin){ create(:admin) }
    let!(:note){ create(:note) }
    context "ログインしているとき" do
      before do
        sign_in admin
      end
      it "リクエストが成功するか" do
        delete admins_note_path(note),
          params: { note: FactoryBot.attributes_for(:note,id: note.id) }
      end
      it "削除は成功するか" do
        expect do
          delete admins_note_path(note),
            params: { note: FactoryBot.attributes_for(:note,id: note.id) }
          # binding.pry
        end.to change(Note,:count).by(-1)
      end
      it "リダイレクトされるか" do
        delete admins_note_path(note),
          params: { note: FactoryBot.attributes_for(:note,id: note.id) }
        expect(response).to redirect_to admins_notes_path
      end
    end
  end
end

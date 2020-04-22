require 'rails_helper'

  # インスタンス変数
  # viewの表示が正しいか
  # postでやるときは paramsで飛ばす
  # ユーザ認証

  # http_status 200 成功 非同期のためレスポンスは200(xhr:true)
  # 302 リダイレクト

RSpec.describe Admins::UsersController, type: :request do
  describe "get #index" do
    let!(:admin){ create(:admin) }
    let!(:user){ create(:user) }
    context "ログインしている場合" do
      before do
        sign_in admin
      end
      it "リクエストは成功するか" do
        get admins_users_path
        expect(response).to have_http_status(200)
      end
      it "ユーザ情報が表示されているか" do
        get admins_users_path
        expect(response.body).to include "テスト太郎"
      end
    end

    context "ログインしていない場合" do
      it "リダイレクトされるか" do
        get admins_users_path
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "get #show" do
    let!(:admin){ create(:admin) }
    let!(:user){ create(:user) }
    context "ログインしている場合" do
      before do
        sign_in admin
      end
      it "リクエストは成功するか" do
        get admins_user_path(user)
        expect(response).to have_http_status(200)
      end
      it "ユーザ情報が表示されているか" do
        get admins_user_path(user)
        expect(response.body).to include "テストテストテストテスト"
      end
    end

    context "ログインしていない場合" do
      it "リダイレクトされるか" do
        get admins_user_path(user)
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "delete #destroy" do
    let!(:admin){ create(:admin) }
    let!(:user){ create(:user) }
    before do
      sign_in admin
    end
    it "リクエストは成功するか" do
      delete admins_user_path(user),
        params: { user: FactoryBot.attributes_for(:user,id: user.id) }
      expect(response).to have_http_status(302)
    end
    it "削除は成功するか" do
      expect do
        delete admins_user_path(user),
          params: { user: FactoryBot.attributes_for(:user,id: user.id) }
      end.to change(User, :count).by(-1)
    end
    it "リダイレクトされるか" do
      delete admins_user_path(user),
        params: { user: FactoryBot.attributes_for(:user,id: user.id) }
      expect(response).to redirect_to admins_users_path
    end
  end

  describe "patch #update" do
    let!(:admin){ create(:admin) }
    let!(:user){ create(:user) }
    before do
      sign_in admin
    end
    context "パラメータが正しい場合" do
      it "リクエストは成功するか" do
        user.destroy
        patch admins_user_path(user),
          params: { user: FactoryBot.attributes_for(:user,id: user.id) }
        expect(response).to have_http_status(302)
      end
      it "更新は成功するか" do
        user.destroy
        expect do
          patch admins_user_path(user),
            params: { user: FactoryBot.attributes_for(:user,id: user.id) }
        end.to change(User, :count).by(1)
      end
    end

    context "パラメータが正しくない場合" do
      it "リクエストは成功するか" do
        patch admins_user_path(user),
          params: { user: FactoryBot.attributes_for(:user,id: user.id) }
        expect(response).to have_http_status(302)
      end
    end
  end
end

require 'rails_helper'

  # インスタンス変数
  # viewの表示が正しいか
  # postでやるときは paramsで飛ばす
  # ユーザ認証

  # http_status 200 成功 非同期のためレスポンスは200(xhr:true)
  # 302 リダイレクト

RSpec.describe Admins::TagsController, type: :request do
  describe "get #index" do
    let!(:admin){ create(:admin) }
    let!(:tag){ create(:tag) }
    context "ログインしているとき" do
      before do
        sign_in admin
      end
      it "リクエストは成功するか" do
        get admins_tags_path
        expect(response).to have_http_status(200)
      end
      it "登録されたタグは表示されているか" do
        get admins_tags_path
        expect(response.body).to include "テストタグ"
      end
    end

    context "ログインしていないとき" do
      it "リダイレクトされるか" do
        get admins_tags_path
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "get #edit" do
    let!(:admin){ create(:admin) }
    let!(:tag){ create(:tag) }
    context "ログインしているとき" do
      before do
        sign_in admin
      end
      it "リクエストは成功するか" do
        get edit_admins_tag_path(tag)
        expect(response).to have_http_status(200)
      end
      it "画面は表示されているか" do
        get edit_admins_tag_path(tag)
        expect(response.body).to include "#000000"
      end
    end
    context "ログインしていないとき" do
      it "リダイレクトされるか" do
        get edit_admins_tag_path(tag)
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "patch #update" do
    let!(:admin){ create(:admin) }
    let!(:tag){ create(:tag) }
    context "パラメータが正しいとき" do
      before do
        sign_in admin
      end
      it "リクエストは成功するか" do
        patch admins_tag_path(tag),
          params: {acts_as_taggable_on_tag: FactoryBot.attributes_for(:tag,color_code: "#FFFFFF") }
        expect(response).to have_http_status(302)
      end
      it "データは更新されるか" do
        expect do
          patch admins_tag_path(tag),
            params: {acts_as_taggable_on_tag: FactoryBot.attributes_for(:tag,color_code: "#FFFFFF") }
        end.to change{ ActsAsTaggableOn::Tag.find(tag.id).color_code }.from("#000000").to("#FFFFFF")
      end
      it "リダイレクトされるか" do
        patch admins_tag_path(tag),
          params: {acts_as_taggable_on_tag: FactoryBot.attributes_for(:tag,color_code: "#FFFFFF") }
        expect(response).to redirect_to admins_tags_path        
      end
    end
    
    context "パラメータが正しくないとき" do
      it "リクエストは成功するか" do
        patch admins_tag_path(tag),
          params: {acts_as_taggable_on_tag: FactoryBot.attributes_for(:tag,color_code: "") }
        expect(response).to have_http_status(302)
      end
      it "更新に失敗するか" do
        expect do
          patch admins_tag_path(tag),
            params: {acts_as_taggable_on_tag: FactoryBot.attributes_for(:tag,color_code: "") }
        end.not_to change{ActsAsTaggableOn::Tag.find(tag.id).color_code}
      end
    end
  end
end
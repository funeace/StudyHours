require 'rails_helper'

  # インスタンス変数
  # viewの表示が正しいか
  # postでやるときは paramsで飛ばす
  # ユーザ認証

  # http_status 200 成功 非同期のためレスポンスは200(xhr:true)
  # 302 リダイレクト

describe RelationshipsController, type: :request do
  let(:user){ create(:user) }
  let(:other_user){ create(:other_user) }
  before do
    sign_in user
  end
  describe "POST #create" do
    context "パラメータが正しい時" do
      it "リクエストが成功するか" do
        post relationships_path(user_id: other_user.id),
          params: {user_id: user.id,follow_id: other_user.id},
            xhr: true
        expect(response).to have_http_status(200)
      end
      it "フォローが成功するか" do
        expect do
          post relationships_path(user_id: other_user.id),
            params: {user_id: user.id, follow_id: other_user.id},
              xhr: true
        end.to change(Relationship, :count).by(1)
      end
    end
    context "パラメータが不正な時" do
      it "リクエストが成功するか" do
        post relationships_path(user_id: other_user.id),
          params: {user_id: "",follow_id: other_user.id},
            xhr: true
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:relationship){ Relationship.create(user_id: user.id,follow_id: other_user.id)}
    it "リクエストが成功するか" do
      delete relationship_path(other_user),
        params: {user_id: user.id,follow_id: other_user.id},
          xhr: true
      expect(response).to have_http_status(200)
    end
    it "フォローが解除されるか" do
      expect do
        delete relationship_path(other_user),
          params: {user_id: user.id,follow_id: other_user.id},
            xhr: true
      end.to change(Relationship, :count).by(-1)
    end
  end
end
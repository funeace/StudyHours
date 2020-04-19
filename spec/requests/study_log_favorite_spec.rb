require 'rails_helper'

  # インスタンス変数
  # viewの表示が正しいか
  # postでやるときは paramsで飛ばす
  # ユーザ認証

  # http_status 200 成功
  # 302 リダイレクト

describe StudyLogFavoritesController, type: :request do
  let!(:user){ create(:user) }
  let!(:study_log){ create(:study_log) }
  before do
    sign_in user
  end
  
  describe "POST #create" do
    context "有効なパラメータの場合" do
      it "リクエストは成功するか" do
        # ajax通信のため、200
        post study_log_study_log_favorites_path(study_log_id: study_log.id),
         params: {study_log_favorite: FactoryBot.attributes_for(:study_log_favorite)}, xhr: true
        expect(response).to have_http_status(200)
      end
      it "更新に成功するか" do
        expect do
          post study_log_study_log_favorites_path(study_log_id: study_log.id),
           params: {study_log_favorite: FactoryBot.attributes_for(:study_log_favorite)}, xhr: true
        end.to change(StudyLogFavorite, :count).by(1)
      end
    end
    context "無効なパラメータの場合" do
      it "リクエストは成功するか" do
        post study_log_study_log_favorites_path(study_log_id: study_log.id),
         params: {study_log_favorite: FactoryBot.attributes_for(:study_log_favorite,user_id: "")}, xhr: true
      end
    end
  end

  describe "DELETE #destoroy" do
    let!(:study_log_favorite){ StudyLogFavorite.create(user_id: user.id,study_log_id: study_log.id) }

    it "リクエストは成功するか" do
        delete study_log_study_log_favorites_path(study_log_id: study_log.id),
          params: {user_id: user.id,study_log_id: study_log.id}, xhr: true
        expect(response).to have_http_status(200)
    end
    it "削除されるか" do
      expect do
        delete study_log_study_log_favorites_path(study_log_id: study_log.id),
          params: {user_id: user.id,study_log_id: study_log.id}, xhr: true
      end.to change(StudyLogFavorite,:count).by(-1)
    end      
  end
end
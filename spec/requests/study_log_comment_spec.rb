require 'rails_helper'

  # インスタンス変数
  # viewの表示が正しいか
  # postでやるときは paramsで飛ばす
  # ユーザ認証

  # http_status 200 成功　→ 非同期実行のためcreateも200
  # 302 リダイレクト

describe StudyLogCommentsController, type: :request do
  let!(:user){create(:user)}
  let!(:study_log){create(:study_log)}
  before do
    sign_in user
  end
  describe "POST #create" do
    context "有効なパラメータの場合" do
      it "リクエストは成功するか" do
        post study_log_study_log_comments_path(study_log_id: study_log.id),
          params: {study_log_comment: FactoryBot.attributes_for(:study_log_comment)},
          xhr: true
        expect(response).to have_http_status(200)
      end
      it "投稿は成功するか" do
        expect do
          post study_log_study_log_comments_path(study_log_id: study_log.id),
            params: {study_log_comment: FactoryBot.attributes_for(:study_log_comment)},
            xhr: true
        end.to change(StudyLogComment, :count).by(1) 
      end
    end
    context "無効なパラメータの場合" do
      it "リクエストは成功するか" do
        post study_log_study_log_comments_path(study_log_id: study_log.id),
          params: {study_log_comment: FactoryBot.attributes_for(:study_log_comment,comment:"")},
          xhr: true
        # binding.pry
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:study_log_comment){create(:study_log_comment)}
    it "リクエストは成功するか" do
      delete study_log_study_log_comment_path(study_log_comment,study_log_id: study_log.id),
        params: {study_log_comment: FactoryBot.attributes_for(:study_log_comment)},
        xhr: true
      expect(response).to have_http_status(200)
    end
    it "削除は成功するか" do
      expect do
      delete study_log_study_log_comment_path(study_log_comment,study_log_id: study_log.id),
        params: {study_log_comment: FactoryBot.attributes_for(:study_log_comment)},
        xhr: true
      end.to change(StudyLogComment, :count).by(-1)
    end
  end

end
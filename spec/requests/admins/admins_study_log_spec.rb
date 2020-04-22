require 'rails_helper'

  # インスタンス変数
  # viewの表示が正しいか
  # postでやるときは paramsで飛ばす
  # ユーザ認証

  # http_status 200 成功 非同期のためレスポンスは200(xhr:true)
  # 302 リダイレクト

RSpec.describe Admins::StudyLogsController, type: :request do
  describe "get #index" do
    let!(:admin){ create(:admin) }
    let!(:study_log){ create(:study_log) }
    let!(:study_log_detail){ create(:study_log_detail,study_log_id: study_log.id) }
    context "ログインしているとき" do
      before do
        sign_in admin
      end
      it "リクエストは成功するか" do
        get admins_study_logs_path
        expect(response).to have_http_status(200)
      end
      it "投稿内容は表示されているか" do
        get admins_study_logs_path
        # binding.pry
        expect(response.body).to include "studyテスト"
      end
    end

    context "ログインしていないとき" do
      it "リダイレクトされるか" do
        get admins_study_logs_path
        expect(response).to have_http_status(302) 
      end
    end
  end

  describe "get #show" do
    let!(:admin){ create(:admin) }
    let!(:study_log){ create(:study_log) }
    let!(:study_log_detail){ create(:study_log_detail,study_log_id: study_log.id)}
    context "ログインしているとき" do
      before do
        sign_in admin
      end
      it "リクエストは成功するか" do
        get admins_study_log_path(study_log)
        expect(response).to have_http_status(200)
      end
      it "投稿内容は表示されているか" do
        get admins_study_log_path(study_log)
        expect(response.body).to include "studyテスト"
      end
    end
    context "ログインしていないとき" do
      it "リダイレクトされるか" do
        get admins_study_log_path(study_log)
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "delete #destroy" do
    let!(:admin){ create(:admin) }
    let!(:study_log){ create(:study_log) }
    let!(:study_log_detail){ create(:study_log_detail,study_log_id: study_log.id)}
    before do
      sign_in admin
    end
    it "リクエストは成功するか" do
      delete admins_study_log_path(study_log),
        params: { study_log: FactoryBot.attributes_for(:study_log,id: study_log.id) }
      expect(response).to have_http_status(302)
    end
    it "削除されるか" do
      expect do
        delete admins_study_log_path(study_log),
          params: { study_log: FactoryBot.attributes_for(:study_log,id: study_log.id) }
      end.to change(StudyLog, :count).by(-1)
    end
    it "リダイレクトされるか" do
      delete admins_study_log_path(study_log),
        params: { study_log: FactoryBot.attributes_for(:study_log,id: study_log.id) }
      expect(response).to redirect_to admins_study_logs_path
    end
  end
end
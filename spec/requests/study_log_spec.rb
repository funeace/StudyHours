require 'rails_helper'

  # インスタンス変数
  # viewの表示が正しいか
  # postでやるときは paramsで飛ばす
  # ユーザ認証

  # http_status 200 成功
  # 302 リダイレクト

describe StudyLogsController, type: :request do
  describe "GET #show" do
    let!(:user){ create(:user) }
    let!(:study_log){ create(:study_log) }
    let!(:study_log_comment){ build(:study_log_comment) }

    it "リクエストが成功するか" do
      get study_log_path(study_log)
      expect(response).to have_http_status(200)
    end

    it "学習記録が表示されているか" do
      get study_log_path(study_log)
      expect(response.body).to include "studyテスト"
    end

    it "コメントが表示されているか" do
      study_log_comment.study_log_id = study_log.id
      study_log_comment.user_id = user.id
      study_log_comment.save
      get study_log_path(study_log)
      expect(response.body).to include "てすてすてす"
    end
  end

  describe "GET #new" do
    let!(:user){ create(:user) }
    let!(:study_log){ create(:study_log) }
    context "ログインしている場合" do
      before do
        sign_in user
      end
      it "リクエストが成功するか" do
        get new_study_log_path
        expect(response).to have_http_status(200)
      end
    end
    context "ログインしていない場合" do
      it "リダイレクトが発生するか" do
        get new_study_log_path
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

      it "リクエストが成功するか" do
        post study_logs_path params: {study_log: FactoryBot.attributes_for(:study_log,user_id: user.id)}
        # binding.pry
        expect(response).to have_http_status(302)
      end

      it "投稿できるか" do
        expect do
          post study_logs_path params: {study_log: FactoryBot.attributes_for(:study_log,user_id: user.id) }
        end.to change(StudyLog, :count).by(1)
      end

      it "リダイレクト先は正しいか" do
        post study_logs_path params: { study_log: FactoryBot.attributes_for(:study_log,user_id: user.id) }
        expect(response).to redirect_to study_log_path(StudyLog.last)
      end
    end

    context "パラメータが正しくない場合" do
      it "リクエストが成功するか" do
        post study_logs_path params: { study_log: FactoryBot.attributes_for(:study_log,user_id:"") }
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "GET #edit" do
    let!(:user){ create(:user) }
    let!(:study_log){ create(:study_log,user_id: user.id) }
    context "ログインしている時" do
      before do
        sign_in user
      end

      it "リクエストが成功するか" do
        get edit_study_log_path(study_log)
        expect(response).to have_http_status(200)
      end

      it "メモが入力されているか" do
        get edit_study_log_path(study_log)
        expect(response.body).to include "studyテスト"
      end
    end
    context "ログインしていない時" do
      it "リクエストが失敗するか" do
        get edit_user_path(user)
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "PATCH #update" do
    let!(:user){create(:user)}
    let!(:study_log){create(:study_log)}
    before do
      sign_in user
    end

    context "パラメータが正しい場合" do
      it "リクエストが成功するか" do
        patch study_log_path(study_log.id), params: { memo: "hogehogehogehoge", study_log: FactoryBot.attributes_for(:study_log) }
        expect(response).to have_http_status(302)
      end

      it "更新できるか" do
        expect do
          patch study_log_path(study_log), params: { study_log: FactoryBot.attributes_for(:study_log,memo:"hogehoge") }
        end.to change {StudyLog.find(study_log.id).memo}.from("studyテスト").to("hogehoge")
      end
    end
    context "パラメータが正しくない場合" do
      it "リクエストが成功するか" do
        patch study_log_path(study_log.id), params: { study_log: FactoryBot.attributes_for(:study_log,user_id:"",memo:"失敗") }
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "DELETE #delete" do
    let!(:user){create(:user)}
    let!(:study_log){create(:study_log)}
    before do
      sign_in user
    end
    context "パラメータが正しい場合" do
      it "リクエストが成功するか" do
        delete study_log_path(user)
        expect(response).to have_http_status(302)
      end
      it "データは削除されるか" do
        expect do
          delete study_log_path(user)
        end.to change(StudyLog,:count).by(-1)
      end
      it "リダイレクト先は正しいか" do
        delete study_log_path(user)
        expect(response).to redirect_to timelines_path   
      end    
    end
  end
end
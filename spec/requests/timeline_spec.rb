require 'rails_helper'

  # インスタンス変数
  # viewの表示が正しいか
  # postでやるときは paramsで飛ばす
  # ユーザ認証

  # http_status 200 成功
  # 302 リダイレクト

describe TimelinesController, type: :request do
  describe "GET #index" do
    context "ログインしているとき"
      let!(:user){ create(:user) }
      let!(:other_user){ create(:other_user) }
      let!(:relationship) { Relationship.create(user_id: other_user.id,follow_id: user.id)}
      let!(:study_log){ build(:study_log) }
      let!(:note){ build(:note) }

      before do
        sign_in user
      end
      it "リクエストが成功するか" do
        get timelines_path
        expect(response).to have_http_status(200)
      end

      it "自分の学習記録が表示されているか" do
        study_log.save
        get timelines_path
        expect(response.body).to include "studyテスト"
      end

      it "自分のノートが表示されているか" do
        note.save
        get timelines_path
        expect(response.body).to include "noteテスト"
      end

      it "フォロー中ユーザの学習記録が表示されているか" do
        study_log.user_id = other_user.id
        study_log.save
        get timelines_path
        expect(response.body).to include "studyテスト"
      end

      it "フォロー中ユーザのノートが表示されているか" do
        note.user_id = other_user.id
        note.save
        get timelines_path
        expect(response.body).to include "noteテスト"
      end
    end

    context "ログインしていないとき" do
      it "リダイレクトされるか" do
        get timelines_path
        expect(response).to have_http_status(302)
      end
    end
  end

require 'rails_helper'

  # インスタンス変数
  # viewの表示が正しいか
  # postでやるときは paramsで飛ばす
  # ユーザ認証

  # http_status 200
  # 302 リダイレクト

describe NotificationsController, type: :request do
  describe "GET #index"
  context "ログインしている場合" do
    let!(:user){ create(:user) }
    let!(:other_user){ create(:other_user) }
    let!(:follow){ create(:notification_follow,user_id: other_user.id, visit_id: user.id) }
    let!(:study_log_favorite){ create(:notification_study_log_favorite,user_id: other_user.id, visit_id: user.id) }
    let!(:study_log_comment){ create(:notification_study_log_comment,user_id: other_user.id, visit_id: user.id) }
    let!(:note_favorite){ create(:notification_note_favorite,user_id: other_user.id, visit_id: user.id) }
    let!(:note_comment){ create(:notification_note_comment,user_id: other_user.id, visit_id: user.id) }
    let!(:checked){ create(:notification_check,user_id: other_user.id,visit_id: user.id) }
    before do
      sign_in user
    end
    it "フォローのリクエストは成功するか" do
      get notifications_path
      expect(response).to have_http_status(200)
    end
    it "フォローの通知は表示されるか" do
      get notifications_path
      # binding.pry
      expect(response.body).to include "あなたをフォローしました" 
    end
    it "学習記録いいねの通知は表示されるか" do
      get notifications_path
      expect(response.body).to include "積み上げ</a></b>にいいねしました"
    end
    it "学習記録コメントの通知は表示されるか" do
      get notifications_path
      expect(response.body).to include "積み上げ</a></b>にコメントしました"
    end

    it "ノートいいねの通知は表示されるか" do
      get notifications_path
      expect(response.body).to include "ノート</a></b>にいいねしました"
    end
    it "ノートコメントの通知は表示されるか" do
      get notifications_path
      expect(response.body).to include "ノート</a></b>にコメントしました"
    end
    it "checkedは有効化されているか(falseが-1)" do
      expect do
        get notifications_path
      end.to change(Notification.where(checked: false), :count).by(-1)
    end
  end
  context "ログインしていない場合" do
    let!(:user){ create(:user) }
    let!(:other_user){ create(:other_user) }
    it "リクエストは失敗するか" do
      get notifications_path
      expect(response).to have_http_status(302)
    end
  end

end

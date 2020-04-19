require 'rails_helper'

  # インスタンス変数
  # viewの表示が正しいか
  # postでやるときは paramsで飛ばす
  # ユーザ認証

  # http_status 200 成功
  # 302 リダイレクト

describe UsersController, type: :request do
  describe "GET #show" do
    # 事前データの呼び出し
    let!(:user) { create(:user) }
    let!(:note) { create(:note) }
    let!(:study_log) { create(:study_log) }
    before do
      sign_in user
    end

    it "リクエストが成功するか" do
      get user_path(user)
      expect(response).to have_http_status(200)
    end

    it "noteのタイトルが表示されているか" do
      get user_path(user)
      note.user_id = user.id
      expect(response.body).to include "noteテスト"
    end

    it "studylogのメモが表示されていること" do      
      study_log.user_id = user.id
      get user_path(user)
      expect(response.body).to include "studyテスト" 
    end

    it "ユーザ名が取得できているか" do
      get user_path(user)
      expect(response.body).to include "テスト太郎"
    end
  end

  describe "GET #edit" do
    let!(:user) { create(:user) }
    context "ログインしているとき" do
      before do
        sign_in user
      end
    
      it "リクエストが成功するか" do
        get edit_user_path(user)
        expect(response).to have_http_status(200)
      end

      it "ユーザ名が表示されているか" do
        get edit_user_path(user)
        expect(response.body).to include "テスト太郎"
      end
    end
    context "ログインしていないとき" do
      it "リクエストが失敗するか" do
        get edit_user_path(user)
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "PATCH #update" do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:other_user) }

    context "ログインしているとき" do
      before do
        sign_in user
      end

      it "リクエストが成功するか" do
        patch user_path(user), params:{id: user.id,user: FactoryBot.attributes_for(:other_user)}
        # redirect
        expect(response).to have_http_status(302)
      end

      it "ユーザ名が更新されるか" do
        expect do
          patch user_path(user), params:{id:user.id,user: FactoryBot.attributes_for(:other_user) }
        end.to change {User.find(user.id).name}.from("テスト太郎").to("テスト次郎")
      end

      it "リダイレクトされるか" do
        patch user_path(user), params:{id:user.id,user: FactoryBot.attributes_for(:other_user) }
        expect(response).to redirect_to detail_user_path(user.id)
      end
    end

    context "パラメータが不正なとき" do

      # 本当に302???
      it "リクエストが成功すること" do
        patch user_path(user), params:{id: user.id,user: FactoryBot.attributes_for(:user, :invalid)}
        expect(response).to have_http_status(302)
      end

      it "ユーザー名が更新されない" do
        expect do
          patch user_path(user), params:{id:user.id,user: FactoryBot.attributes_for(:other_user,:invalid) }
        end.not_to change {User.find(user.id).name}
      end
    end
  end

  describe "GET #detail" do
    let!(:user) { create(:user) }
    it "リクエストが成功するか" do
      get detail_user_path(user)
      expect(response).to have_http_status(200)
    end

    it "ユーザ名が表示されているか" do
      get detail_user_path(user)
      expect(response.body).to include "テスト太郎"
    end
  end

  describe "GET #following" do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:other_user) }
    let!(:relationship) { Relationship.create(user_id: user.id,follow_id: other_user.id)}

    it "リクエストが成功するか" do
      get following_user_path(user)
      expect(response).to have_http_status(200)
    end
    it "フォロー中ユーザが表示されるか" do
      get following_user_path(user)
      expect(response.body).to include "テスト次郎"
    end
  end

  describe "GET #followers" do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:other_user) }
    let!(:relationship) { Relationship.create(user_id: other_user.id,follow_id: user.id)}

    it "リクエストが成功するか" do
      get followers_user_path(user)
      expect(response).to have_http_status(200)
    end
    it "フォロワーが表示されるか" do
      get followers_user_path(user)
      expect(response.body).to include "テスト次郎"
    end
  end

  describe "GET #favorites" do
    let!(:user){ create(:user) }
    let!(:note) { create(:note) }
    let!(:study_log) { create(:study_log) }
    let!(:note_favorite){ NoteFavorite.create(user_id: user.id,note_id: note.id)}
    let!(:study_log_favorite){ StudyLogFavorite.create(user_id: user.id,study_log_id: study_log.id)}
    it "リクエストが成功するか" do
      get favorites_user_path(user)
      expect(response).to have_http_status(200)
    end
    it "ノートのお気に入りの一覧が表示されるか" do
      # p note_favorite
      get favorites_user_path(user)
      expect(response.body).to include "noteテスト"
    end

    it "学習記録のお気に入りの一覧が表示されるか" do
      # p study_log_favorite
      get favorites_user_path(user)
      expect(response.body).to include "noteテスト"
    end    
  end
end
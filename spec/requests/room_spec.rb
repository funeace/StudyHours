require 'rails_helper'

  # インスタンス変数
  # viewの表示が正しいか
  # postでやるときは paramsで飛ばす
  # ユーザ認証

  # http_status 200
  # 302 リダイレクト

describe RoomsController, type: :request do
  describe "GET index" do
    let!(:user){ create(:user) }
    let!(:other_user){ create(:other_user) }

    context "ログインしている時" do
      before do
        sign_in user
      end
      it "リクエストは成功するか" do
        get rooms_path
        expect(response).to have_http_status(200)
      end
      it "ユーザが表示されているか" do
        get rooms_path
        expect(response.body).to include "テスト次郎"
      end
    end
    context "ログインしていない時" do
      it "リクエストは失敗するか" do
        get rooms_path
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "GET #show" do
    let!(:user){ create(:user) }
    let!(:other_user){ create(:other_user) }
    let!(:room){ Room.create }
    let!(:chat){ Chat.create(user_id: user.id,room_id: room.id,content:"てすとてすと")}
    context "ログインしている時" do
      before do
        sign_in user
      end
      it "リクエストは成功するか" do
        get room_path(room)
        expect(response).to have_http_status(200)
      end
      it "チャットルームが表示されているか" do
        get room_path(room)
        expect(response.body).to include "てすとてすと"
      end
    end

    context "ログインしていない時" do
      it "リクエストは失敗するか" do
        get room_path(room)
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "POST #create" do
    let!(:user){ create(:user) }
    let!(:other_user){ create(:other_user) }

    context "ログインしているかつ、entryがない場合" do
      before do
        sign_in user
      end
      it "リクエストは成功するか" do
        post rooms_path(user_id: other_user.id)
        expect(response).to have_http_status(302)
      end
      it "roomが作成されるか" do
        expect do
          post rooms_path(user_id: other_user.id)
          # binding.pry
        end.to change(Room,:count).by(1)
      end
      it "entryが作成されない" do
        expect do
          post rooms_path(user_id: other_user.id)
        end.to change(Entry,:count).by(2)
      end
      it "リダイレクトされるか" do
        post rooms_path(user_id: other_user.id)
        expect(response).to redirect_to room_path(Room.last)
      end
    end

    context "ログインしているかつ、entryがある場合" do
      let!(:room){ create(:room) }
      let!(:entry){ Entry.create(user_id: user.id,room_id: room.id) }
      let!(:other_entry){ Entry.create(user_id: other_user.id,room_id: room.id) }
      before do
        sign_in user
      end
      it "リクエストは成功するか" do
        post rooms_path(user_id: other_user.id)
        expect(response).to have_http_status(302)
      end
      it "roomがが作成されないか" do
        expect do
          post rooms_path(user_id: other_user.id)
        end.not_to change(Room,:count)
      end
      it "entryが作成されないか" do
        expect do
          post rooms_path(user_id: other_user.id)
        end.not_to change(Entry,:count)
      end
      it "リダイレクトされるか" do
        post rooms_path(user_id: other_user.id)
        expect(response).to redirect_to room_path(room.id)
      end
    end

    context "ログインしていない場合" do
      it "リクエストは失敗するか" do
        post rooms_path(user_id: other_user.id)
        expect(response).to have_http_status(302)
      end
    end
  end
end
class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:user_id])
    # 自分をフォローしようとしていないか確認
    current_user.follow(@user)
    @user.create_notification_follow!(current_user, 'follow')
    # 非同期化
    # redirect_back(fallback_location: root_path)
  end

  def destroy
    @user = User.find(params[:id])
    current_user.unfollow(@user)
    # 非同期化
    # redirect_back(fallback_location: root_path)
  end
end

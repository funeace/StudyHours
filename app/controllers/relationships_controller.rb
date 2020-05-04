class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user)
    @user.create_notification_follow!(current_user, 'follow')
  end

  def destroy
    @user = User.find(params[:id])
    current_user.unfollow(@user)
  end
end

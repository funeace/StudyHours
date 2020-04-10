class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @user = User.find(params[:user_id])
    # 自分をフォローしようとしていないか確認
    if current_user != @user
      current_user.follow(@user)
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(@user)
    redirect_back(fallback_location: root_path)
  end
end

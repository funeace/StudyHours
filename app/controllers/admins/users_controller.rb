class Admins::UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.with_deleted.order(:created_at).page(params[:page]).per(6)
  end

  def show
    @user = User.with_deleted.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admins_users_path
    flash[:info] = "ユーザ情報を無効化しました"
    # binding.pry
  end

  def update
    @user = User.with_deleted.find(params[:id])
    @user.restore
    redirect_to admins_users_path
    flash[:info] = "ユーザ情報を復元しました"
  end
end
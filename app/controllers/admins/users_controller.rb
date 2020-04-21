class Admins::UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.all.order(:created_at)
  end

  def show
    @user = User.find(params[:id])
  end
end
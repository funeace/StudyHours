class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @notes = @user.notes
    @records = @user.records
  end

  def detail
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    # binding.pry
    if @user.update(user_params)
      flash[:info] = "更新しました"
      redirect_to detail_user_path(@user)
    else
      render 'edit'
    end
  end

private
  def user_params
  params.require(:user).permit(:name,:email,:goal_hour,:goal_minute,:introduction,:profile_image_id)
  end
end

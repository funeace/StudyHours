class StudyLogsController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :correct_user, only: %i[edit]

  def show
    @study_log = StudyLog.find(params[:id])
    @study_log_comments = @study_log.study_log_comments.all
    @study_log_comment = @study_log.study_log_comments.new
  end

  def new
    @study_log = current_user.study_logs.new
  end

  def create
    @study_log = current_user.study_logs.new(study_log_params)
    # study_logに紐づけているtagをモデル内のset_taglist_existに送る
    @study_log.set_taglist_exist(params[:study_log][:tag_list].split(',').size)
    if @study_log.save
      # tagのカラーコードがnilのものにカラーコードを付与
      create_tag_color
      flash[:success] = '登録が完了しました。この調子で頑張りましょう'
      redirect_to study_log_path(@study_log)
    else
      render 'new'
    end
  end

  def edit
    @study_log = StudyLog.find(params[:id])
  end

  def update
    @study_log = StudyLog.find(params[:id])
    @study_log.set_taglist_exist(params[:study_log][:tag_list].split(',').size)
    if @study_log.update(study_log_params)
      flash[:success] = '更新が完了しました。'
      redirect_to study_log_path(@study_log)
      # tagのカラーコードがnilのものにカラーコードを付与
      create_tag_color
    else
      render 'edit'
    end
  end

  def destroy
    study_log = StudyLog.find(params[:id])
    study_log.destroy
    flash[:notice] = '投稿を削除しました。'
    redirect_to timelines_path
  end

  private

  def study_log_params
    params.require(:study_log).permit(:working_date, :memo, :hour, :minute, :tag_list)
  end

  def correct_user
    @study_log = StudyLog.find(params[:id])
    redirect_to root_path unless current_user.id == @study_log.user_id
  end
end

class Admins::StudyLogsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @study_logs = StudyLog.all
  end

  def show
    @study_log = StudyLog.find(params[:id])
    @study_log_comments = @study_log.study_log_comments.all
  end

  def destroy
    @study_log = StudyLog.find(params[:id])
    # binding.pry
    @study_log.destroy
    redirect_to admins_study_logs_path
    flash[:info] = "学習記録を削除しました"
  end
end

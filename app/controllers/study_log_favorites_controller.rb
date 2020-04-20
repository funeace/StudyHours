class StudyLogFavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_study_log

  def create
    @study_log = StudyLog.find(params[:study_log_id])
    @study_log.study_log_favorites.create(user_id: current_user.id)
    # binding.pry
    @study_log.create_notification_favorite!(current_user,"study_log_favorite")
    # redirect_back(fallback_location: root_path)
  end

  def destroy
    @study_log = StudyLog.find(params[:study_log_id])
    # binding.pry
    @study_log.study_log_favorites.find_by(user_id: current_user.id).destroy
    # redirect_back(fallback_location: root_path)
  end
private
  def set_study_log
    @study_log = StudyLog.find(params[:study_log_id])
  end
end

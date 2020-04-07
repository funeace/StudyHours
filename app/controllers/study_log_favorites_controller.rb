class StudyLogFavoritesController < ApplicationController
    def create
    @study_log = StudyLog.find(params[:study_log_id])
    @study_log.study_log_favorites.create(user_id: current_user.id)
    redirect_back(fallback_location: root_path)   
  end

  def destroy
    @study_log = StudyLog.find(params[:study_log_id])
    # binding.pry
    @study_log.study_log_favorites.find_by(user_id: current_user.id).destroy
    redirect_back(fallback_location: root_path)
  end
end

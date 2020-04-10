class SearchsController < ApplicationController
  def index
    @users = User.all
    @notes = Note.all
    @study_logs = StudyLog.all

  end
end

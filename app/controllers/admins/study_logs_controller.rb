class Admins::StudyLogsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @study_logs = StudyLog.all
  end
end

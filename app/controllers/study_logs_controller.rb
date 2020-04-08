class StudyLogsController < ApplicationController
  def show
    @study_log = StudyLog.find(params[:id])
    @study_log_comment = @study_log.study_log_comments.new
  end

  def new
    @study_log = current_user.study_logs.new
    @study_log.study_log_details.build
  end

  def create
    @study_log = current_user.study_logs.new(study_log_params)
    if @study_log.save
      flash[:notice] = "登録が完了しました。この調子で頑張りましょう"
      redirect_to timelines_path
    else
      render 'new'
    end
  end
private
  def study_log_params
    params.require(:study_log).permit(:working_date,:memo,study_log_details_attributes:[:tag_list,:hour,:min])
  end
end

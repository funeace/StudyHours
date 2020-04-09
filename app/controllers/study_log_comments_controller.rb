class StudyLogCommentsController < ApplicationController
  def create
    @study_log = StudyLog.find(params[:study_log_id])
    study_log_comment = current_user.study_log_comments.new(study_log_comment_params)
    study_log_comment.study_log_id = @study_log.id
    if study_log_comment.save
      redirect_to study_log_path(@study_log)
    else
      render 'show'
    end
  end

 private
  def study_log_comment_params
    params.require(:study_log_comment).permit(:study_log_id ,:comment)
  end
end

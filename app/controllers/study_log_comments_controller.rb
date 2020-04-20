class StudyLogCommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @study_log = StudyLog.find(params[:study_log_id])
    @study_log_comment = current_user.study_log_comments.new(study_log_comment_params)
    @study_log_comment.study_log_id = @study_log.id
    @study_log_comment.save

    @study_log_comments = @study_log.study_log_comments.all
    @study_log.create_notification_comment!(current_user,@study_log_comment.id,"study_log_comment")
    #   redirect_to study_log_path(@study_log)
    # else
    #   render 'show'
    # end
  end

  def destroy
    @study_log = StudyLog.find(params[:study_log_id])
    @study_log_comment = StudyLogComment.find(params[:id]).destroy
    @study_log_comments = @study_log.study_log_comments.all
    # binding.pry
  end

 private
  def study_log_comment_params
    params.require(:study_log_comment).permit(:study_log_id ,:comment)
  end
end

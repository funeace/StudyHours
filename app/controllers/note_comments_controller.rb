class NoteCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @note = Note.find(params[:note_id])
    @note_comment = current_user.note_comments.new(note_comment_params)
    @note_comment.note_id = @note.id
    @note_comment.save
    @note_comments = @note.note_comments.all
    @note.create_notification_comment!(current_user, @note_comment.id, 'note_comment')
  end

  def destroy
    @note = Note.find(params[:note_id])
    @note_comment = NoteComment.find(params[:id]).destroy
    @note_comments = @note.note_comments.all
  end

  private

  def note_comment_params
    params.require(:note_comment).permit(:note_id, :comment)
  end
end

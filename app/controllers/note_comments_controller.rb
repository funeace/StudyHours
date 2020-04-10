class NoteCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @note = Note.find(params[:note_id])
    note_comment = current_user.note_comments.new(note_comment_params)
    note_comment.note_id = @note.id
    if note_comment.save
      redirect_to note_path(@note)
    else
      render 'show'
    end
  end

private
  def note_comment_params
    params.require(:note_comment).permit(:note_id ,:comment)
  end

end

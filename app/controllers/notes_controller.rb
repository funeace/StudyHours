class NotesController < ApplicationController
  def new
    @note = current_user.notes.new
  end

  def create
    @note = current_user.notes.new(note_params)
    if @note.save
      flash[:notice] = "ノートを投稿しました。"
    else
      render 'new'
    end
    redirect_to timelines_path
  end

  def show
    @note = Note.find(params[:id])
    @note_comment = @note.note_comments.new
  end

private
  def note_params
    params.require(:note).permit(:user_id,:title,:body,:tag_list)
  end
end

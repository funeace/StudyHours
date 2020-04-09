class NotesController < ApplicationController
  def new
    @note = current_user.notes.new
  end

  def create
    @note = current_user.notes.new(note_params)
    if @note.save
      flash[:notice] = "ノートを投稿しました。"
      redirect_to note_path(@note)
    else
      render 'new'
    end
    redirect_to timelines_path
  end

  def show
    @note = Note.find(params[:id])
    @note_comments = @note.note_comments.all
    @note_comment = @note.note_comments.new
  end

  def edit
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])
    if @note.update(note_params)
      flash[:notice] = "ノートを更新しました"
      redirect_to note_path(@note)
    else
      render 'edit'
    end
  end

  def destroy
    note = Note.find(params[:id])
    note.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to timelines_path
  end


private
  def note_params
    params.require(:note).permit(:user_id,:title,:body,:tag_list)
  end
end

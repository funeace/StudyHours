class NotesController < ApplicationController
  before_action :authenticate_user!, except: %i[show]
  before_action :correct_user, only: %i[edit]

  def new
    @note = current_user.notes.new
  end

  def create
    @note = current_user.notes.new(note_params)
    @note.set_taglist_exist(params[:note][:tag_list].split(',').size)
    if @note.save
      # 以下はランダムなカラーコードを作成するメソッドを呼び出している
      create_tag_color
      flash[:success] = 'ノートを投稿しました。'
      redirect_to note_path(@note)
    else
      render 'new'
    end
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
    @note.set_taglist_exist(params[:note][:tag_list].split(',').size)

    if @note.update(note_params)
      flash[:success] = 'ノートを更新しました'
      redirect_to note_path(@note)
      # 以下はランダムなカラーコードを作成するメソッドを呼び出している
      create_tag_color
    else
      render 'edit'
    end
  end

  def destroy
    note = Note.find(params[:id])
    note.destroy
    flash[:warning] = '投稿を削除しました。'
    redirect_to timelines_path
  end

  # 以下APIの処理
  def preview
    @body = view_context.markdown(params[:body])
    respond_to do |format|
      format.json
    end
  end

  private

  def note_params
    params.require(:note).permit(:user_id, :title, :body, :tag_list)
  end

  def correct_user
    @note = Note.find(params[:id])
    redirect_to root_path unless current_user.id == @note.user_id
  end
end

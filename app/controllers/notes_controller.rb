class NotesController < ApplicationController
  before_action :authenticate_user!,except: [:show]
  
  def new
    @note = current_user.notes.new
  end

  def create
    @note = current_user.notes.new(note_params)    
    # noteに紐づけているtagをモデル内のset_taglist_existに送る
    @note.set_taglist_exist(params[:note][:tag_list])
    if @note.save
      # tagのカラーコードがnilのものにカラーコードを付与するメソッド
      create_tag_color
      flash[:notice] = "ノートを投稿しました。"
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
    if @note.update(note_params)
      flash[:notice] = "ノートを更新しました"
      redirect_to note_path(@note)
      # tagのカラーコードがnilのものにカラーコードを付与
      create_tag_color
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

# APIの処理
  def preview
    @body = view_context.markdown(params[:body])
    respond_to do |format|
      format.json
    end
  end


private
  def note_params
    params.require(:note).permit(:user_id,:title,:body,:tag_list)
  end
end

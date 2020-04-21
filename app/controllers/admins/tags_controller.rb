class Admins::TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.all
  end

  def edit
    @tag = ActsAsTaggableOn::Tag.find(params[:id])

    # jsに現在のカラーコードを渡す
    gon.color = @tag.color_code
  end

  def update
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
    if @tag.update(tag_params)
      redirect_to admins_tags_path
      flash[:info] = "カラーコードの更新が完了しました"
    else
      render 'edit'
    end
  end
private
  def tag_params
    params.require(:acts_as_taggable_on_tag).permit(:color_code)
  end
end

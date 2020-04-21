class Admins::TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.all
  end

  def edit
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
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
  #acts_as_taggable_onのテーブルを更新するため
  def tag_params
    params.require(:acts_as_taggable_on_tag).permit(:color_code)
  end
end

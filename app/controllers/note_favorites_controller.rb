class NoteFavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @note = Note.find(params[:note_id])
    @note.note_favorites.create(user_id: current_user.id)
    redirect_back(fallback_location: root_path)   
  end

  def destroy
    @note = Note.find(params[:note_id])
    # binding.pry
    @note.note_favorites.find_by(user_id: current_user.id).destroy
    redirect_back(fallback_location: root_path)
  end
end

class RecordFavoritesController < ApplicationController
  def create
    @record = Record.find(params[:record_id])
    @record.record_favorites.create(user_id: current_user.id)
    redirect_back(fallback_location: root_path)   
  end

  def destroy
    @record = Record.find(params[:record_id])
    # binding.pry
    @record.record_favorites.find_by(user_id: current_user.id).destroy
    redirect_back(fallback_location: root_path)
  end
end

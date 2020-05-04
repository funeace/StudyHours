class NoteFavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_note_favorite

  def create
    @note = Note.find(params[:note_id])
    @note.note_favorites.create(user_id: current_user.id)
    @note.create_notification_favorite!(current_user, 'note_favorite')
  end

  def destroy
    @note = Note.find(params[:note_id])
    @note.note_favorites.find_by(user_id: current_user.id).destroy
  end

  private

  def set_note_favorite
    @note = Note.find(params[:note_id])
  end
end

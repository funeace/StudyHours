class UsersController < ApplicationController
  def index
    @notes = Note.all
  end
end

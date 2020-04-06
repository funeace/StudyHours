class UsersController < ApplicationController
  def show
    @notes = Note.all
    @records = Record.all
    # binding.pry
  end
end

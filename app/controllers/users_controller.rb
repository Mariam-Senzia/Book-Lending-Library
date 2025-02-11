class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @borrowed_books = @user.books

    respond_to do |format|
      format.html 
      format.json { render json: { user: @user, borrowed_books: @borrowed_books } }
    end
  end
end
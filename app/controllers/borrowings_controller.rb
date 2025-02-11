class BorrowingsController < ApplicationController
  before_action :authenticate_user!

  def return_book
    borrowing = Borrowing.find_by(user: current_user, book_id: params[:id])

    respond_to do |format|
      if borrowing
        borrowing.destroy
        borrowing.book.update(available: true)
        format.html { redirect_to books_path, notice: "Book returned successfully" }
        format.json { render json: { message: "Book returned successfully" }, status: :ok }
      else
        format.html { redirect_to books_path, alert: "You cannot return a book you have not borrowed" }
        format.json { render json: { error: "You cannot return a book you have not borrowed" }, status: :unprocessable_entity }
      end
    end
  end
end
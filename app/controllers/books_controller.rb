class BooksController < ApplicationController
  def index
    @books = Book.all
    respond_to do |format|
      format.html 
      format.json { render json: @books } 
    end
  end

  def show
    @book = Book.find_by(id: params[:id])
    respond_to do |format|
      if @book
        format.html 
        format.json { render json: @book }
      else
        format.html { redirect_to books_path, alert: "Book not found" }
        format.json { render json: { error: "Book not found" }, status: :not_found }
      end
    end
  end

  def borrow
    @book = Book.find_by(id: params[:id])
    if @book.available
      Borrowing.create(user: current_user, book: @book, due_date: 2.weeks.from_now)
      @book.update(available: false)
      respond_to do |format|
        format.html { redirect_to books_path, notice: "You have successfully borrowed the book" }
        format.json { render json: { message: "You have successfully borrowed the book" }, status: :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to books_path, alert: "This book is already borrowed" }
        format.json { render json: { error: "This book is already borrowed" }, status: :unprocessable_entity }
      end
    end
  end
end
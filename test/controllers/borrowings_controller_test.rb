require "test_helper"

class BorrowingsControllerTest < ActionDispatch::IntegrationTest
  def setup 
    @user = User.create!(name: "test", email: "test@gmail.com", password: "123")
    @book = Book.create!(title: "Test Book", author: "Test Author", isbn: "1234567890", available: false)
    @borrowing = Borrowing.create!(user: @user, book: @book)
  end

  def log_in_as(user)
    post login_url, params: { email: user.email, password: user.password }
  end

  test "should return book successfully" do
    log_in_as(@user) 

    delete return_book_borrowing_url(@borrowing.id), as: :json

    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal "Book returned successfully", json_response["message"]

    assert @book.reload.available
  end  

  test "should not return a book not borrowed" do
    log_in_as(@user)

    @borrowing.destroy

    delete return_book_borrowing_url(@book.id), as: :json

    assert_response :unprocessable_entity
    json_response = JSON.parse(response.body)
    assert_equal "You cannot return a book you have not borrowed", json_response["error"]
  end
end
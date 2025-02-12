require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(name: "Test User", email: "test@gmail.com", password: "123")
    @book = Book.create!(title: "Test Book", author: "Test Author", genre: "Fiction", isbn: "1234567890", description: "A great book.", image_url: "http://example.com/image.jpg", available: true)
    @borrowing = Borrowing.create!(user: @user, book: @book, due_date: 1.week.from_now)  # Create a borrowing record
  end

  test "should get show if authenticated" do
    post login_path, params: { email: @user.email, password: "123" }
    get user_path(@user)
    assert_response :success
  end

  test "should redirect to login if not authenticated" do
    get user_path(@user)
    assert_redirected_to login_path
  end

  test "should display borrowed books if user has borrowed books" do
    post login_path, params: { email: @user.email, password: "123" }
    get user_path(@user)
    assert_response :success
    assert_select "h2.profile-title", "Borrowed Books"
    assert_select ".profile-book-card", 1 
    assert_select "p", text: "Author: Test Author"
    assert_select "p", text: /Due Date: \w+ \d{1,2}, \d{4}/
  end

  test "should display no books message if user has not borrowed any books" do
    new_user = User.create!(name: "New User", email: "new_user@gmail.com", password: "123")
    
    post login_path, params: { email: new_user.email, password: "123" }
    get user_path(new_user)
    assert_response :success
    assert_select "p.no-books", "You have not borrowed any books yet."
  end
end
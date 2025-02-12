require "test_helper"

class BorrowingTest < ActiveSupport::TestCase
  def setup 
    @user = User.create(name: "test", email: "test@gmail.com", password: "123")
    @book = Book.create(title: "Test Book", author: "Test Author", isbn: "1234567890")
    @borrowing = Borrowing.new(user: @user, book: @book)
  end

  test "should be valid with a user and book" do
    assert @borrowing.valid?
  end

  test "should require a user" do
    @borrowing.user = nil
    assert_not @borrowing.valid?
    assert_includes @borrowing.errors[:user], "must exist"
  end

  test "should require a book" do
    @borrowing.book = nil
    assert_not @borrowing.valid?
    assert_includes @borrowing.errors[:book], "must exist"
  end

  test "should prevent borrowing an already borrowed book" do
    @borrowing.save
    another_borrowing = Borrowing.new(user: @user, book: @book)

    assert_not another_borrowing.valid?
    assert_includes another_borrowing.errors[:book], "is already borrowed"
  end
end

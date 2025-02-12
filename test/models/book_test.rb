require "test_helper"

class BookTest < ActiveSupport::TestCase
  def setup
    @book = Book.new(title: "Test Book", author: "Test Author", isbn: "1234567890")
  end

  test "should have all required attributes" do
    assert @book.valid?
  end

  test "should be invalid without a title" do 
    @book.title = nil
    assert_not @book.valid?
    assert_includes @book.errors[:title], "can't be blank"
  end

  test "should be invalid without a author" do 
    @book.author = nil
    assert_not @book.valid?
    assert_includes @book.errors[:author], "can't be blank"
  end

  test "should be invalid without a ISBN" do 
    @book.isbn = nil
    assert_not @book.valid?
    assert_includes @book.errors[:isbn], "can't be blank"
  end

  test "should have a unique ISBN" do
    book1 = Book.create(title: "Book One", author: "Author One", isbn: "1234567890")
    book2 = Book.new(title: "Book Two", author: "Author Two", isbn: "1234567890")

    assert_not book2.valid? 
    assert_includes book2.errors[:isbn], "has already been taken"
  end

  test "should respond to borrowings" do 
    assert_respond_to @book, :borrowings
  end

  test "should respond to users" do
    assert_respond_to @book, :users
  end

  test "borrowed? should return true if book is borrowed" do
    @book.save
    user = User.create(name: "test",email: "test2@gmail.com", password: "123")
    borrowing = Borrowing.create!(user: user, book: @book, due_date: 2.weeks.from_now)

    assert @book.borrowed?
  end  

  test "borrowed? should return false if book is not borrowed" do
    @book.save
    assert_not @book.borrowed?
  end
end

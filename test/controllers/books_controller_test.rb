require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(name: "test", email: "test@gmail.com", password: "123")
    @book = Book.create(title: "Test Book", author: "Test Author", isbn: "1234567890", genre: "Fiction", description: "A great book.", image_url: "http://example.com/image.jpg", available: true)
  end

  test "should get index as JSON" do
    get books_url, as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_kind_of Array, json_response
  end

  test "should show book as JSON" do
    get book_url(@book), as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal @book.id, json_response["id"]
  end

  test "should return not found for invalid book as JSON" do
    get book_url(id: 9999), as: :json
    assert_response :not_found
    json_response = JSON.parse(response.body)
    assert_equal "Book not found", json_response["error"]
  end

  test "should borrow book as JSON" do
    patch borrow_book_url(@book), params: {}, headers: { "Authorization" => @user.id }, as: :json
    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal "You have successfully borrowed the book", json_response["message"]
    
    @book.reload 
    assert_not @book.available
  end

  test "should not borrow an already borrowed book as JSON" do
    @book.update!(available: false) 

    patch borrow_book_url(@book), params: {}, headers: { "Authorization" => @user.id }, as: :json
    assert_response :unprocessable_entity
    json_response = JSON.parse(response.body)
    assert_equal "This book is already borrowed", json_response["error"]
  end

  test "should display books at index" do
    get books_url
    assert_response :success 

    assert_select "h2", "Available Books" 
    assert_select ".book-card", minimum: 1
    assert_select "img[src='#{@book.image_url}']" 
    assert_select "h3", @book.title 
    assert_select "p", text: "Author: #{@book.author}" 
    assert_select "p", text: "Genre: #{@book.genre}"  
    assert_select "p", text: "Status: Available" 
    assert_select "a", text: "View Details" 
  end

  test "should display book details on show page" do
    post login_url, params: { email: @user.email, password: "123" }, as: :json
    assert_response :ok 

    get book_url(@book)
    assert_response :success 

    assert_select "img[src='#{@book.image_url}']" 
    assert_select "h2", @book.title 
    assert_select "p", text: "Description: #{@book.description}"  
    assert_select "p", text: "Author: #{@book.author}"  
    assert_select "p", text: "Genre: #{@book.genre}"  
    assert_select "p", text: "ISBN: #{@book.isbn}" 
    assert_select "p", text: "Status: Available"  

    if @book.available
      assert_select "button", text: "Borrow Book"  
    else
      borrowing = Borrowing.find_by(user: @user, book: @book)
      if borrowing
        assert_select "button", text: "Return Book"  
      else
        assert_select "p", text: "Oops!" 
      end
    end
  end
end

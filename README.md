
# Book Lending Library (Rails 8)

This is a simple **Book Lending Library** application built with **Ruby on Rails 8**.
Users can browse available books, view detailed information about each book, and after logging in, they can borrow and return books, as well as track their borrowed books.

---

## Features

- **User Authentication** (Registration & Login using Rails 8 default authentication system)
- **Book Listing Page** (Shows books and their availability status)
- **Book Details Page** (Shows book details and allows borrowing if available)
- **Borrowing a Book** (Creates a Borrowing record with a due date)
- **Returning a Book** (Marks books as available again)
- **User Profile Page** (Lists the user's currently borrowed books)

---

## Prerequisites

- **Ruby**: `>= 3.2.0`
- **Rails**: `8.x`
- **SQLite**

---

## 🛠️ Installation & Setup

Run the following commands in your terminal:
### 1️⃣ Clone the Repository

```sh
git clone git@github.com:Mariam-Senzia/Book-Lending-Library.git
cd book-lending-library
```
    
2️⃣ Install Dependencies

```sh
bundle install
```

3️⃣ Setup the Database

```sh
rails db:create
rails db:migrate
rails db:seed
```
    
4️⃣ Start the Rails Server

```sh
rails server
```
The app will be available at http://localhost:3000.

---

## 🧪 Running Tests
The application includes tests for models, controllers, and views using the default Rails testing framework(Minitest). These tests ensure that the application functions as expected and that all features work correctly

### Run All Tests

```sh
rails test
```

### Run Tests by Category

- **Model tests:**

```sh
rails test test/models/book_test.rb
rails test test/models/borrowing_test.rb
rails test test/models/user_test.rb
```
        
- **Controller & View tests:**

```sh
rails test test/controllers/auth_controller_test.rb
rails test test/controllers/books_controller_test.rb
rails test test/controllers/borrowings_controller_test.rb
rails test test/controllers/users_controller_test.rb
```

---

## 📜 License

This project is open-source and available under the MIT License.
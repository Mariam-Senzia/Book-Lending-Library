User.destroy_all
Book.destroy_all
Borrowing.destroy_all

books = [
  { title: "How to Stop Worrying and Start Living", author: "Dale Carnegie", isbn: "9780671027032", available: true, description: "A self-help book that provides practical advice and techniques for overcoming worry and anxiety.", genre: "Self-Help", image_url: "https://m.media-amazon.com/images/I/71PtTe33l5L._AC_UF1000,1000_QL80_.jpg" },
  { title: "Rich Dad Poor Dad", author: "Robert Kiyosaki", isbn: "9781612680194", available: true, description: "A personal finance book that contrasts the financial philosophies of Kiyosaki's two 'dads' and offers insights on building wealth.", genre: "Personal Finance", image_url: "https://m.media-amazon.com/images/I/71o4HTng33L._AC_UF1000,1000_QL80_.jpg" },
  { title: "The Alchemist", author: "Paulo Coelho", isbn: "9780061122415", available: true, description: "A philosophical novel about a shepherd named Santiago who dreams of finding treasure in Egypt, exploring themes of destiny and personal legend.", genre: "Fiction", image_url: "https://diwanegypt.com/wp-content/uploads/2020/08/9780007155668-1.jpg" },
  { title: "The Psychology of Money", author: "Morgan Housel", isbn: "9788126571512", available: true, description: "A book that explores the ways people think about money and how it affects their financial decisions.", genre: "Personal Finance", image_url: "https://nuriakenya.com/wp-content/uploads/2021/02/The-Psychology-of-Money-NuriaKenya.jpg" },
  { title: "The Great Gatsby", author: "F. Scott Fitzgerald", isbn: "9780743273565", available: true, description: "A classic novel set in the Jazz Age that tells the story of Jay Gatsby and his unrequited love for Daisy Buchanan, exploring themes of wealth, love, and the American Dream.", genre: "Classic Literature", image_url: "https://m.media-amazon.com/images/I/61z0MrB6qOS._AC_UF1000,1000_QL80_.jpg" },
  { title: "Think and Grow Rich", author: "Napoleon Hill", isbn: "9781937879505", available: true, description: "A classic self-help book that outlines key principles for achieving personal and financial success based on the author's study of successful individuals.", genre: "Self-Help", image_url: "https://m.media-amazon.com/images/I/618eO0O6fLL._AC_UF1000,1000_QL80_.jpg" }
]

books.each do |book_data|
    book = Book.create(book_data)
    if book.persisted?
      puts "Book '#{book.title}' created successfully!"
    else
      puts "Failed to create book '#{book.title}': #{book.errors.full_messages.join(", ")}"
    end
end


puts "Seed data added successfully!"

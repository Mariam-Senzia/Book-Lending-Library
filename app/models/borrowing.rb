class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validate :book_not_already_borrowed

  def book_not_already_borrowed
    if book.present? && book.borrowings.exists?
      errors.add(:book, "is already borrowed")
    end
  end  
end

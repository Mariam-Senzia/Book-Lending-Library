class Book < ApplicationRecord
    validates :title, :author, :isbn, presence: true
    validates :isbn, uniqueness: true

    has_many :borrowings 
    has_many :users, through: :borrowings

    def mark_as_borrowed
        update(available: false)
    end

    def mark_as_returned
        update(available:true)
    end
end
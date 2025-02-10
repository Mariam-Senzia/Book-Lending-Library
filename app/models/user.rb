class User < ApplicationRecord
    has_secure_password

    has_many :borrowings
    has_many :books, through: :borrowings
end

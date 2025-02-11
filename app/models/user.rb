class User < ApplicationRecord
    has_secure_password

    has_many :borrowings
    has_many :books, through: :borrowings

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
end

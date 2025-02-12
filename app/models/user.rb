VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]{2,}\z/i

class User < ApplicationRecord
    has_secure_password

    has_many :borrowings
    has_many :books, through: :borrowings

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX, message: "is invalid" }
end
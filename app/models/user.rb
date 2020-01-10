class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  validates :username, presence: true, length: {within: 6..40}
  validates :password, confirmation: true,
                       length: {within: 6..40},
                       on: :create
  validates :password, confirmation: true,
                       length: {within: 6..40},
                       allow_blank: true,
                       on: :update
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "invalid email" }
  has_secure_password
end

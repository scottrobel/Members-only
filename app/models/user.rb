class User < ApplicationRecord
  before_save { self.email = email.downcase }
  has_many :posts, dependent: :destroy
  validates :username, length: {within: 6..40}
  validates :username, uniqueness: true, allow_blank: true
  validates :password, confirmation: true,
                       length: {within: 6..40},
                       allow_blank: true,
                       on: :update
  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "not valid" }, uniqueness: true, allow_blank: true
  has_secure_password
end

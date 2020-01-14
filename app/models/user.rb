class User < ApplicationRecord
  before_save { self.email = email.downcase }
  has_many :posts, dependent: :destroy
  validates :username, presence: true
  validates :username, length: {within: 6..40}, allow_blank: true
  validates :username, uniqueness: true, allow_blank: true
  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "not valid" }, uniqueness: true, allow_blank: true
  has_secure_password

  def new_token
    token = SecureRandom.urlsafe_base64
    remember_digest = Digest::SHA1.hexdigest(token)
    update_attribute(:remember_digest,  remember_digest)
    token
  end

  def check_token(token)
    Digest::SHA1.hexdigest(token) == remember_digest
  end
end

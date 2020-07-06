class User < ApplicationRecord
  has_many :appointments
  has_secure_password

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :token, format: { with: /[A-Fa-f0-9]{64}/ }
end

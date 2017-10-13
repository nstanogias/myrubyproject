class User < ApplicationRecord
  has_many :movies, dependent: :destroy
  has_secure_password
  validates :username, presence: true
  validates :password, presence: true, length: { minimum: 5 }, allow_nil: true
end

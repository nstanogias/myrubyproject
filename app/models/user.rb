class User < ApplicationRecord
  has_many :movies, dependent: :destroy
  has_secure_password
  validates :username, presence: true
  validates :password, presence: true, length: { minimum: 5 }, allow_nil: true
  has_many :comments, dependent: :destroy
  has_many :messages, dependent: :destroy
end

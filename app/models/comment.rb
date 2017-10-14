class Comment < ApplicationRecord
  validates :description, presence: true, length: { minimum: 4, maximum: 140 }
  belongs_to :user
  belongs_to :movie
  validates :user_id, presence: true
  validates :movie_id, presence: true
end

class Movie < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  belongs_to :user
  default_scope -> { order(updated_at: :desc) }
  has_many :movie_genres
  has_many :genres, through: :movie_genres
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def thumbs_up_total
    self.likes.where(like: true).size
  end

  def thumbs_down_total
    self.likes.where(like: false).size
  end
end

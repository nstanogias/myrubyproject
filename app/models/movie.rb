class Movie < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  belongs_to :user
  default_scope -> { order(updated_at: :desc) }
end

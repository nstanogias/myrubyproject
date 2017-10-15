class Like < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates_uniqueness_of :user, scope: :movie
end

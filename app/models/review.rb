class Review < ApplicationRecord
  belongs_to :cruise
  # belongs_to :user

  validates :rating, presence: true
end

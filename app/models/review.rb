class Review < ApplicationRecord
  belongs_to :cruise
  belongs_to :user

  validates :content, presence: true
  validates :rating, presence: true, inclusion: 0..5, numericality: { only_integer: true }
end

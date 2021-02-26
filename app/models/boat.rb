class Boat < ApplicationRecord
  include PgSearch::Model
  belongs_to :user
  has_many :cruises, dependent: :destroy
  has_many_attached :photos

  validates :name, presence: true
  validates :description, presence: true
  validates :capacity, presence: true
  validates :category, presence: true

  multisearchable against: [:name, :category]
end

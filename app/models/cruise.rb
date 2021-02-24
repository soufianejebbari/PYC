class Cruise < ApplicationRecord
  belongs_to :boat
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :price, presence: true
  validates :start_location, presence: true
  validates :end_location, presence: true
  validates :difficulty, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end

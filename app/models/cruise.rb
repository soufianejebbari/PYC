class Cruise < ApplicationRecord
  belongs_to :boat
  has_many :bookings, dependent: :destroy

  has_many :reviews, dependent: :destroy
  belongs_to :start_location, class_name: "Location", foreign_key: "start_location_id"
  belongs_to :end_location, class_name: "Location", foreign_key: "end_location_id"

  validates :name, presence: true
  validates :description, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :price, presence: true
  validates :start_location, presence: true
  validates :end_location, presence: true
  validates :difficulty, presence: true

  def self.departure_locations
    Cruise.all.map do |cruise|
      Location.find(cruise.start_location_id)
    end
  end
end

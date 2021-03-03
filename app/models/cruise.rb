class Cruise < ApplicationRecord
  include PgSearch::Model
  belongs_to :boat
  has_many :bookings, dependent: :destroy
  has_many :stops, dependent: :destroy

  has_many :reviews, dependent: :destroy
  # belongs_to :start_location, class_name: "Location", foreign_key: "start_location_id"
  # belongs_to :end_location, class_name: "Location", foreign_key: "end_location_id"

  validates :name, presence: true
  validates :description, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :price, presence: true
  validates :difficulty, presence: true

  def self.departure_locations
    Cruise.all.map do |cruise|
      cruise.start_location
    end
  end

  def start_location
    # self.stops.find_by(start_location: true).location if self.stops.find_by(start_location: true)
    self.stops.first.location
  end

  def end_location
    # self.stops.find_by(end_location: true).location if self.stops.find_by(end_location: true)
    self.stops.last.location
  end

  def routing
   self.route = stops.each_cons(2).map { |step| GetRoute.new([step.first, step.last]).call}.flatten(1)
   self.save
  end

end

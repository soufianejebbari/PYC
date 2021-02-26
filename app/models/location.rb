class Location < ApplicationRecord
  include PgSearch::Model
  has_many :cruises

  geocoded_by :name
  after_validation :geocode, if: :will_save_change_to_name?
  multisearchable against: [:start_location, :end_location]
end

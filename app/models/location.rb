class Location < ApplicationRecord
  has_many :stops
  has_many :cruises, through: :stops

  geocoded_by :name
  after_validation :geocode, if: :will_save_change_to_name?


end


#jointure avec alias
# has_many :cruises, foreign_key:"start_location_id", class_name:"Cruise"
# has_many :cruises, foreign_key:"end_location_id", class_name:"Cruise"

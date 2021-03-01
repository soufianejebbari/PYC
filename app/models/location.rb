class Location < ApplicationRecord
  has_many :stops

  geocoded_by :name
  after_validation :geocode, if: :will_save_change_to_name?

  scope :by_random, -> {reorder(Arel.sql("RANDOM()")) }
end


#jointure avec alias
# has_many :cruises, foreign_key:"start_location_id", class_name:"Cruise"
# has_many :cruises, foreign_key:"end_location_id", class_name:"Cruise"

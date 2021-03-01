class Stop < ApplicationRecord
  belongs_to :location
  belongs_to :cruise
end

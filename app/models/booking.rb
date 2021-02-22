class Booking < ApplicationRecord
  belongs_to :cruise
  belongs_to :user

  has_many :messages, dependent: :destroy
end

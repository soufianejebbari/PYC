class AddSeatsToBookings < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :seats, :integer, default: 1
  end
end

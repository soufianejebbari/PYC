class AddColumnToStops < ActiveRecord::Migration[6.0]
  def change
    add_column :stops, :start_location, :Boolean
    add_column :stops, :end_location, :Boolean
  end
end

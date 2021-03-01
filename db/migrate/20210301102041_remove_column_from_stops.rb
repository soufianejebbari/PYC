class RemoveColumnFromStops < ActiveRecord::Migration[6.0]
  def change
    remove_column :stops, :start_location, :string
    remove_column :stops, :end_location, :string
  end
end

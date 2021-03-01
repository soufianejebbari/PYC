class RemoveColumnFromCruises < ActiveRecord::Migration[6.0]
  def change
    remove_column :cruises, :start_location_id, :string
    remove_column :cruises, :end_location_id, :string
  end
end

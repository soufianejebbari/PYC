class CreateStops < ActiveRecord::Migration[6.0]
  def change
    create_table :stops do |t|
      t.integer :position
      t.string :start_location
      t.string :end_location
      t.references :location, null: false, foreign_key: true
      t.references :cruise, null: false, foreign_key: true

      t.timestamps
    end
  end
end

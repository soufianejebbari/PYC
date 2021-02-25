class CreateCruises < ActiveRecord::Migration[6.0]
  def change
    create_table :cruises do |t|
      t.date :start_date
      t.date :end_date
      t.integer :price
      t.references :boat, null: false, foreign_key: true
      t.references :start_location, foreign_key: { to_table: :locations }, index: true
      t.references :end_location, foreign_key: { to_table: :locations }, index: true

      t.timestamps
    end
  end
end

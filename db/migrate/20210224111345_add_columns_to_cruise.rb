class AddColumnsToCruise < ActiveRecord::Migration[6.0]
  def change
    add_column :cruises, :name, :string
    add_column :cruises, :description, :string
    add_column :cruises, :difficulty, :integer
  end
end

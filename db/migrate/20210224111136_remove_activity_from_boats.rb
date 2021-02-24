class RemoveActivityFromBoats < ActiveRecord::Migration[6.0]
  def change
    remove_column :boats, :activity, :string
  end
end

class AddRouteToCruise < ActiveRecord::Migration[6.0]
  def change
    add_column :cruises, :route, :string, array: true, default: []
    # add_column :books, :subjects, :text, array: true, default: []
    #Ex:- :default =>''
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end

class AddLocationToTrips < ActiveRecord::Migration[7.0]
  def change
    add_column :trips, :location, :string
    add_column :trips, :entry_type, :string
    add_column :trips, :entry_key, :string
    add_column :trips, :entry_description, :text
    add_column :trips, :entry_image, :string
  end
end

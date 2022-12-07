class AddPhotoToTrips < ActiveRecord::Migration[7.0]
  def change
    add_column :trips, :photo, :string
  end
end

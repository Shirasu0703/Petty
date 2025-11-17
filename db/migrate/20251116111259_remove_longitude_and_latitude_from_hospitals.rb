class RemoveLongitudeAndLatitudeFromHospitals < ActiveRecord::Migration[6.1]
  def change
    remove_column :hospitals, :longitude, :float
    remove_column :hospitals, :latitude, :float
  end
end

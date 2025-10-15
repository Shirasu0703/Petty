class ChangeLatitudeLongitudeNullableInHospitals < ActiveRecord::Migration[6.1]
  def change
    change_column_null :hospitals, :latitude, true
    change_column_null :hospitals, :longitude, true
  end
end

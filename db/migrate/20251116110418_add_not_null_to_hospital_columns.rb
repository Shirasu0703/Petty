class AddNotNullToHospitalColumns < ActiveRecord::Migration[6.1]
  def change
    change_column_null :hospitals, :opening_hours, false
    change_column_null :hospitals, :animal_types, false
  end
end

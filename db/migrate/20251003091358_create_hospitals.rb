class CreateHospitals < ActiveRecord::Migration[6.1]
  def change
    create_table :hospitals do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.string :phone_number, null: false
      t.string :opening_hours
      t.string :animal_types
      t.float :longitude, null: false
      t.float :latitude, null: false

      t.timestamps
    end
  end
end

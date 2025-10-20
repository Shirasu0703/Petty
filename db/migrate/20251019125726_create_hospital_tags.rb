class CreateHospitalTags < ActiveRecord::Migration[6.1]
  def change
    create_table :hospital_tags do |t|
      t.references :hospital, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end

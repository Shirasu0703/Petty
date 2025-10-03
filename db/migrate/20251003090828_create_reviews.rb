class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :user_id, null: false
      t.integer :hospital_id, null: false
      t.string :rating, null: false
      t.string :title, null: false
      t.text :body, null: false
      t.boolean :published, dedault: true

      t.timestamps
    end
  end
end

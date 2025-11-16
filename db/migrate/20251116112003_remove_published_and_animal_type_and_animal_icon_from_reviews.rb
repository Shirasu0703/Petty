class RemovePublishedAndAnimalTypeAndAnimalIconFromReviews < ActiveRecord::Migration[6.1]
  def change
    remove_column :reviews, :published, :boolean
    remove_column :reviews, :animal_type, :string
    remove_column :reviews, :animal_icon, :string
  end
end

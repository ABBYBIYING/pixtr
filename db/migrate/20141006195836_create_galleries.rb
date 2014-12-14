class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :name
      t.string :cover_image
      t.text :description
      t.integer :user_id

      t.timestamps
    end
  end
end

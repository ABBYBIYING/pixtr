class AddGalleryIdIndexToImage < ActiveRecord::Migration
  def change
    add_index :images, :gallery_id
  end
end

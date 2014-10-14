class CreateGroupsImages < ActiveRecord::Migration
  def change
    create_table :groups_images do |t|
      
    t.references :group, index: true
    t.references :image, index: true
    t.timestamps
    end
  end
end

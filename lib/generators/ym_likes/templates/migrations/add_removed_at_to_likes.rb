class AddRemovedAtToLikes < ActiveRecord::Migration
  
  def change
    add_column :likes, :removed_at, :datetime
  end
  
end
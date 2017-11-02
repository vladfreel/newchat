class RemoveLikesFromImages < ActiveRecord::Migration[5.1]
  def change
    remove_column :images, :likes, :integer
  end
end

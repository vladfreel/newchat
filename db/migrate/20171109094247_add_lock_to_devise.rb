class AddLockToDevise < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :cached_failed_attempts, :integer, default: 0
  end
end

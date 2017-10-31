class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.references :user, foreign_key: true
      t.string :nav
      t.datetime :signin
      t.datetime :signout
      t.string :like
      t.string :comment

      t.timestamps
    end
  end
end

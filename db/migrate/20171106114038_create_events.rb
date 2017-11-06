class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.references :user, foreign_key: true
      t.string :action_type
      t.string :orig_url

      t.timestamps
    end
  end
end

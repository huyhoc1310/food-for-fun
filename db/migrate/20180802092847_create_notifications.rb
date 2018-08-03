class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.text :content
      t.references :restaurant, foreign_key: true

      t.timestamps
    end
  end
end

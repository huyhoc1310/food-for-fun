class CreateFoods < ActiveRecord::Migration[5.2]
  def change
    create_table :foods do |t|
      t.string :name
      t.text :description
      t.float :price
      t.integer :rate
      t.references :restaurant, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end

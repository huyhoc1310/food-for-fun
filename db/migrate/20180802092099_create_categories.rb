class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.references :restaurant, foreign_key: true

      t.timestamps
    end
    add_reference :categories, :parent, index: true
  end
end

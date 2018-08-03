class CreateOderDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :oder_details do |t|
      t.integer :quantity
      t.references :order, foreign_key: true
      t.references :food, foreign_key: true

      t.timestamps
    end
  end
end

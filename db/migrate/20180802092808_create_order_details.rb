class CreateOrderDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :order_details do |t|
      t.integer :quantity
      t.integer :price
      t.float :total_price
      t.integer :restaurant_id
      t.references :order, foreign_key: true
      t.references :food, foreign_key: true

      t.timestamps
    end
  end
end

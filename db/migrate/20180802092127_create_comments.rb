class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :user, foreign_key: true
      t.references :food, foreign_key: true

      t.timestamps
    end
    add_reference :comments, :parent, index: true
  end
end

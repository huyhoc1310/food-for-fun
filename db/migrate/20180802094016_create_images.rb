class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :url
      t.string :image_type
      t.integer :target_id
      t.references :imageable, polymorphic: true, index: true

      t.timestamps
    end
  end
end

class RemoveRatingFromFood < ActiveRecord::Migration[5.2]
  def change
    remove_column :foods, :rate, :integer
  end
end

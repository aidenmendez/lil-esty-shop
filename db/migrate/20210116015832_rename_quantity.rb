class RenameQuantity < ActiveRecord::Migration[5.2]
  def change
    rename_column :discounts, :quantity, :threshold 
  end
end

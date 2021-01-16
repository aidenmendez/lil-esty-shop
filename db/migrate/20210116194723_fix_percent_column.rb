class FixPercentColumn < ActiveRecord::Migration[5.2]
  def change
    change_column :discounts, :percent, :decimal, precision: 3, scale: 2
  end
end

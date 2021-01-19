class AddInvMerchantId < ActiveRecord::Migration[5.2]
  def change
    add_reference :invoices, :merchant, index: true
  end
end

class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :merchant_id,
                        :customer_id

  belongs_to :merchant
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: [:cancelled, :in_progress, :complete]

  def total_revenue
    total = 0

    invoice_items.each do |inv_item|
      item = inv_item.item

      if item.get_discount(inv_item.quantity).any?
        discount_percent = item.get_discount(inv_item.quantity).pluck(:percent).first
        discount_price = inv_item.unit_price * (1 - discount_percent)
        revenue = inv_item.quantity * discount_price
        total += revenue
      else
        revenue = inv_item.quantity * inv_item.unit_price
        total += revenue
      end
    end

    total
  end
end

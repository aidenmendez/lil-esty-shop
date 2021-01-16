class Discount < ApplicationRecord
  belongs_to :merchant

  validates :percent, numericality: true
  validates :threshold, numericality: true
end

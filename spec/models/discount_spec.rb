require 'rails_helper'

RSpec.describe Discount, type: :model do
  describe "relationships" do
    it { should belong_to :merchant }
  end

  describe "validations" do
    validates_numericality_of :percent
    validates_numericality_of :threshold
  end
end

require 'rails_helper'

RSpec.describe "As a merchant" do
  describe "when I visit a discount's show page" do
    before :each do
      @merchant1 = Merchant.create!(name: 'Hair Care')

      @discount1 = Discount.create!(percent: 0.2, threshold: 3, merchant_id:@merchant1.id)
      @discount2 = Discount.create!(percent: 0.4, threshold: 15, merchant_id:@merchant1.id)
      @discount3 = Discount.create!(percent: 0.5, threshold: 30, merchant_id:@merchant1.id)

      visit merchant_discount_path(@merchant1, @discount1)
    end

    it "then I see the bulk discounts quantity and price" do
      expect(page).to have_content("Rate: #{@discount1.percent * 100}%")
      expect(page).to have_content("Minimum quantity: #{@discount1.threshold} items")
    end

    it "then I see a link to edit the bulk discount" do
      expect(page).to have_content("Edit")
    end

    it "when I click the edit link" do
      click_link("Edit")
      expect(current_path).to eq(edit_merchant_discount_path(@merchant1, @discount1))
    end
  end
end
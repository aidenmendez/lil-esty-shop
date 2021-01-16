require 'rails_helper'

RSpec.describe "As a merchant" do
  describe "when I visit a discount's edit page" do
    before(:each) do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @discount1 = Discount.create!(percent: 0.2, threshold: 3, merchant_id:@merchant1.id)

      visit edit_merchant_discount_path(@merchant1, @discount1)
    end

    it "I see that the discounts current attributes are prepoluated in the form" do
      expect(page).to have_field("Discount percentage (as a decimal):", with: @discount1.percent)
      expect(page).to have_field("Minimum item threshold:", with: @discount1.threshold)
    end

    it "When I change any/all of the information and click submit, I am redirected to the bulk discount's show page and see the updated details" do
      fill_in("Discount percentage (as a decimal):", with: 0.1)
      fill_in("Minimum item threshold:", with: 2)

      click_button("Update")

      expect(current_path).to eq(merchant_discount_path(@merchant1, @discount1))
      
      @discount1.reload
      expect(page).to have_content("Rate: #{@discount1.percent * 100}%")
      expect(page).to have_content("Minimum quantity: #{@discount1.threshold} items")
    end
  end
end
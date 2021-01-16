require 'rails_helper'

RSpec.describe "As a merchant" do
  describe "when I visit my bulk discounts new page" do
    before :each do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @discount1 = Discount.create!(percent: 0.2, threshold: 3, merchant_id:@merchant1.id)
      @discount2 = Discount.new(percent: 0.5, threshold: 50)
      visit new_merchant_discount_path(@merchant1)
    end

    it "I see a form to add a new bulk discount" do
      within("#new-disc-form") do
        expect(page).to have_field("Discount percentage (as a decimal):")
        expect(page).to have_field("Minimum item threshold:")
      end
    end

    it "When I fill in the form with valid data, I am redirected back to the bulk discount index and I see my new bulk discount listed" do
      # good place for sad path testing-- try including flash messages
      within("#new-disc-form") do
        fill_in("Discount percentage (as a decimal):", with: 0.5)
        fill_in("Minimum item threshold:", with: 50)
        click_button("Submit")
      end

      expect(current_path).to eq(merchant_discounts_path(@merchant1))

      expect(page).to have_content(@discount2.percent)
      expect(page).to have_content(@discount2.threshold)
    end
  end
end
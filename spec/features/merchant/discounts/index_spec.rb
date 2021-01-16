require 'rails_helper'

RSpec.describe "As a merchant" do
  describe "when I visit my bulk discounts index page" do
    before(:each) do
      @merchant1 = Merchant.create!(name: 'Hair Care')

      @discount1 = Discount.create!(percent: 0.2, threshold: 3, merchant_id:@merchant1.id)
      @discount2 = Discount.create!(percent: 0.4, threshold: 15, merchant_id:@merchant1.id)
      @discount3 = Discount.create!(percent: 0.5, threshold: 30, merchant_id:@merchant1.id)

      visit merchant_discounts_path(@merchant1)
    end

    it "I see all of my bulk discounts including their percentage discount and quantity thresholds" do
      within("#section-#{@discount1.id}") do
        expect(page).to have_content(@discount1.percentage)
        expect(page).to have_content(@discount1.threshold)
      end
      within("#section-#{@discount2.id}") do
        expect(page).to have_content(@discount2.percentage)
        expect(page).to have_content(@discount2.threshold)
      end
      within("#section-#{@discount3.id}") do
        expect(page).to have_content(@discount3.percentage)
        expect(page).to have_content(@discount3.threshold)
      end
    end

    it " each bulk discount listed includes a link to its show page" do
      click_link(@discount1.name)
      expect(current_path).to eq(merchant_discount_path(@merchant, @discount1))
    end
  end
end
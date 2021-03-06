require 'rails_helper'

RSpec.describe "As a merchant" do
  describe "when I visit my bulk discounts index page" do
    before(:each) do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      # @merchant2 = Merchant.create!(name: 'Jewelry')

      @discount1 = Discount.create!(percent: 0.2, threshold: 3, merchant_id:@merchant1.id)
      @discount2 = Discount.create!(percent: 0.4, threshold: 15, merchant_id:@merchant1.id)
      @discount3 = Discount.create!(percent: 0.5, threshold: 30, merchant_id:@merchant1.id)

      visit merchant_discounts_path(@merchant1)
    end

    it "I see all of my bulk discounts including their percentage discount and quantity thresholds" do
      within("#section-#{@discount1.id}") do
        expect(page).to have_content("#{@discount1.percent * 100}%")
        expect(page).to have_content(@discount1.threshold)
      end
      within("#section-#{@discount2.id}") do
        expect(page).to have_content("#{@discount2.percent * 100}%")
        expect(page).to have_content(@discount2.threshold)
      end
      within("#section-#{@discount3.id}") do
        expect(page).to have_content("#{@discount3.percent * 100}%")
        expect(page).to have_content(@discount3.threshold)
      end
    end

    it " each bulk discount listed includes a link to its show page" do
      click_link("Discount #{@discount1.id}")
      expect(current_path).to eq(merchant_discount_path(@merchant1, @discount1))
    end

    it "and I click the 'New Discount' link then I am taken to a new page where I see a form to add a new bulk discount" do
      within("#create-discount-sec") do
        click_link("New Discount")
        expect(current_path).to eq(new_merchant_discount_path(@merchant1))
      end
    end

    it "next to each bulk discount I see a link to delete it" do
      within ("#section-#{@discount1.id}") do
        expect(page).to have_button("Delete")
      end

      within ("#section-#{@discount2.id}") do
        expect(page).to have_button("Delete")
      end

      within ("#section-#{@discount3.id}") do
        expect(page).to have_button("Delete")
      end
    end

    it "when I click the delete link next to a discount I am redirected to the discount index page and I no longer see the deleted discount" do
      within ("#section-#{@discount2.id}") do
        click_button("Delete")
      end

      expect(current_path).to eq(merchant_discounts_path(@merchant1))

      within("#section-#{@discount1.id}") do
        expect(page).to have_content("#{@discount1.percent * 100}%")
        expect(page).to have_content(@discount1.threshold)
      end

      within("#section-#{@discount3.id}") do
        expect(page).to have_content("#{@discount3.percent * 100}%")
        expect(page).to have_content(@discount3.threshold)
      end

      expect(page).not_to have_selector("#section-#{@discount2.id}")
    end
  end
end
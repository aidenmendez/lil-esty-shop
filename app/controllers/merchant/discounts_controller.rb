class Merchant::DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.discounts
  end

  def show

  end

  def new

  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    percent = params[:percent]
    threshold = params[:quantity]
    Discount.create!(percent: percent, threshold: threshold, merchant_id: merchant.id)

    redirect_to (merchant_discounts_path(merchant))
  end
end
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
    require 'pry'; binding.pry
  end
end
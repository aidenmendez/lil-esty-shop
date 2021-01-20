class Merchant::DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.discounts
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
    @percentage = @discount.percent * 100
  end

  def new

  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    discount = Discount.find(params[:id])
    if params[:discount][:percent].to_f > 1 || params[:discount][:percent].to_f <= 0
      flash.now[:notice] = "Discount not updated. Ensure percent is a value between 0 and 1."
      render :new
    elsif params[:discount][:threshold].to_f <= 0
      flash.now[:notice] = "Discount not updated. Ensure threshold is greater than 0."
      render :new
    else 
      discount.update!(percent: params[:discount][:percent], threshold: params[:discount][:threshold])
      redirect_to merchant_discount_path(merchant, discount)
    end
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    percent = params[:percent]
    threshold = params[:threshold]
    if params[:percent].to_f > 1 || params[:percent].to_f <= 0
      flash.now[:notice] = "Discount not created. Ensure percent is a value between 0 and 1."
      render :new
    elsif params[:threshold].to_f <= 0
      flash.now[:notice] = "Discount not created. Ensure threshold is greater than 0."
      render :new
    else 
      Discount.create!(percent: params[:percent], threshold: params[:threshold], merchant_id: merchant.id)
      redirect_to (merchant_discounts_path(merchant))
    end
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    discount = Discount.find(params[:id])
    discount.destroy

    redirect_to merchant_discounts_path(merchant)
  end
end

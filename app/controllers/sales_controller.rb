class SalesController < ApplicationController
  def new
    @sale = Sale.new
  end

  def create
    params = post_params
    detail = params[:detail]
    category = params[:category]
    value = params[:value].to_i
    discount = params[:discount].to_i
    iva = params[:iva].to_i

    tax = 0
    total = value * (1 - discount / 100.0)
    if iva.zero?
      total *= 1.19
      tax = 19
    end

    sale = Sale.create(cod: rand(0..999), detail: detail, category: category, value: value, discount: discount, tax: tax, total: total)

    if sale.save
      redirect_to sales_done_path
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def done
    @sales = Sale.all
  end

  private
  def post_params
    params.require(:sale).permit(:detail, :category, :value, :discount, :iva)
  end
end

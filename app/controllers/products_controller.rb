class ProductsController < ApplicationController

  def index
    @products = Product.all
    # product_ids = Review.group(:product_id).order('count_product_id DESC').limit(5).count(:product_id).keys
    # @ranking = product_ids.map{|id| Product.find id}
  end

  def show
    @product = Product.find params[:id]
  end

  def search
    @products = Product.where('title LIKE(?)', "%#{params[:keyword]}%")
  end
end

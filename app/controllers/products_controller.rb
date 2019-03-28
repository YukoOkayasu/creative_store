class ProductsController < ApplicationController
before_action :authenticate_user!, except: [:index]

  def index
    @products = Product.all.order("created_at DESC")
    # product_ids = Review.group(:product_id).order('count_product_id DESC').limit(5).count(:product_id).keys
    # @ranking = product_ids.map{|id| Product.find id}
  end

  def show
    @product = Product.find(params[:id])
    @favorite = Favorite.where(user_id: current_user.id)
  end

  def search
    @products = Product.where('title LIKE(?)', "%#{params[:keyword]}%")
  end

  def category
    @products = Product.where(category_id: params[:id]).order("created_at DESC")
  end
end

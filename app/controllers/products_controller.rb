class ProductsController < ApplicationController
before_action :authenticate_user!, except: [:index, :category]

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

  def buy_confirm
    @product = Product.find(params[:id])
    @user = User.find(current_user.id)
    @token = @user.token_id
    if @token.present?
      Payjp.api_key = PAYJP_SECRET_KEY
      @cards = Payjp::Token.retrieve(@token)
    end
  end

  def buy
    @product = Product.find(params[:id])
    @user = User.find(current_user.id)
    Payjp.api_key = PAYJP_SECRET_KEY
    charge = Payjp::Charge.create(
    amount: @product.price,
    customer: @user.customer_id,
    currency: 'jpy',
    )
    @product.update(product_state_id: 2)
    redirect_to user_path
  end
end

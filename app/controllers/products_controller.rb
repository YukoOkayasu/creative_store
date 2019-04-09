class ProductsController < ApplicationController
  before_action :current_cart, :setup_cart_item!, :authenticate_user!, except: [:index, :category]
  protect_from_forgery except:[:buy_confirm, :buy]

  def index
    @products = Product.all.order("created_at DESC")
    # product_ids = Review.group(:product_id).order('count_product_id DESC').limit(5).count(:product_id).keys
    # @ranking = product_ids.map{|id| Product.find id}
  end

  def show
    @product = Product.find(params[:id])
    @favorite = Favorite.where(user_id: current_user.id)
    if current_cart.cart_items.find_by(product_id: params[:id]).blank?
      @cart = current_cart.cart_items.new
    else
      @cart = current_cart.cart_items.find_by(product_id: params[:id])
    end
  end

  def search
    @products = Product.where('title LIKE(?)', "%#{params[:keyword]}%")
  end

  def category
    @products = Product.where(category_id: params[:id]).order("created_at DESC")
  end

  def buy_confirm
    @total_price = get_total_price
    @cart_items = current_cart.cart_items
    @user = User.find(current_user.id)
    @token = @user.token_id
    if @token.present?
      Payjp.api_key = PAYJP_SECRET_KEY
      @cards = Payjp::Token.retrieve(@token)
    end
  end

  def buy
    @user = User.find(current_user.id)
    Payjp.api_key = PAYJP_SECRET_KEY
    charge = Payjp::Charge.create(
    amount: get_total_price,
    customer: @user.customer_id,
    currency: 'jpy',
    )
    current_cart.update(cart_status: 2)
    redirect_to user_path(current_user), notice: "商品を注文しました"

  end

  def get_total_price
    @cart_items = current_cart.cart_items
    sum = 0
    @cart_items.each do |cart|
      sum += (cart.product.price * cart.quantity)
    end
    return sum
  end

end

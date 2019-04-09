class CartsController < ApplicationController
  before_action :current_cart, :setup_cart_item!, only: [:add_item, :update_item, :delete_item]

  def show
    if Cart.find(session[:cart_id]).present?
      @cart = Cart.find(session[:cart_id])
      @cart_items = current_cart.cart_items
      @total_price = get_total_price
    end
  end

  def add_item
    if current_cart.cart_items.find_by(product_id: params[:cart_item][:product_id]).blank?
      @cart_item = current_cart.cart_items.create(product_id: params[:cart_item][:product_id], quantity: params[:cart_item][:quantity])
    else
      @cart_item = current_cart.cart_items.find_by(product_id: params[:cart_item][:product_id])
      @cart_item.quantity = params[:cart_item][:quantity]
      @cart_item.update(quantity: @cart_item.quantity)
    end
    redirect_to current_cart
  end

  # def update_item
  #   @cart_item.update(quantity: params[:cart_item][:quantity].to_i)
  #   redirect_to current_cart
  # end

  def delete_item
    @cart_item.destroy
    redirect_to current_cart
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

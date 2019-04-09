class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :current_cart, :setup_cart_item!, :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [ :username, :email, :password, :password_confirmation, :nickname, :first_name, :last_name, :kana_first_name, :kana_last_name, :telphone_number, :postal_code, :area_id, :city_name, :city_number, :building]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end

  helper_method :current_cart, :setup_cart_item!

  def current_cart
    if user_signed_in?
      if session[:cart_id].present? && (Cart.find(session[:cart_id]).cart_status == 1)
        @cart = Cart.find(session[:cart_id])
      else
        @cart = Cart.create(user_id: current_user.id)
        session[:cart_id] = @cart.id
      end
    end
  end

  def setup_cart_item!
    if user_signed_in?
      unless current_cart.cart_items.blank?
        @cart_item = current_cart.cart_items.find_by(product_id: params[:product_id])
      end
    end
  end

end

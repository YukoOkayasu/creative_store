class UsersController < ApplicationController
before_action :current_cart, :user_default, :authenticate_user!, except:[:about, :news]
protect_from_forgery except: [:card_form, :card_save,:card_delete, :add_card]

  def show
    @cart = Cart.where(user_id: current_user.id, cart_status: 2)
    @favorite = Favorite.where(user_id: current_user.id)
  end

  def about
  end

  def news
  end

  def card_form
  end

  def card_save
    @users = User.where(id: current_user.id)
    Payjp.api_key = PAYJP_SECRET_KEY
    customer = Payjp::Customer.create(card: params[:payjp_token])
    @users.update_all(token_id: params[:payjp_token], customer_id: customer.id)
    redirect_to add_card_users_path
  end

  def card_delete
    Payjp.api_key = PAYJP_SECRET_KEY
    customer = Payjp::Customer.retrieve(@user.customer_id)
    customer.delete
    @user.update_attributes(token_id: nil, customer_id: nil)
    redirect_to :back
  end

  def add_card
    @token = @user.token_id
    Payjp.api_key = PAYJP_SECRET_KEY
    if @token.present?
      @cards = Payjp::Token.retrieve(@token)
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to user_path(@user), notice: "ユーザー情報を変更しました"
    else
      render :edit
    end
  end

  def edit_user
  end

  def history
    @cart = Cart.where(user_id: current_user.id, cart_status: 2)
    @favorite = Favorite.where(user_id: current_user.id)
  end

  def order_history
    @user = User.find(current_user.id)
    @cart = Cart.find(params[:format])
    @cart_items = Cart.find(params[:format]).cart_items
    @total_price = get_total_price
  end

  private

  def user_default
    @user = User.find(current_user)
  end

  def user_params
    params.require(:user).permit(:image, :nickname,:first_name, :last_name, :kana_first_name, :kana_last_name, :postal_code, :area_id, :city_name, :city_number, :building, :telphone_number).merge(id: current_user.id)
  end

  def read
    @tempfile.read
  end

  def get_total_price
    sum = 0
    @cart_items.each do |cart|
      sum += (cart.product.price * cart.quantity)
    end
    return sum
  end

end

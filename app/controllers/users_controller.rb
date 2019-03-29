class UsersController < ApplicationController
before_action :authenticate_user!
protect_from_forgery except: [:card_form, :card_save,:card_delete, :add_card]

  def show
    @user = User.find(current_user.id)
    @favorite = Favorite.where(user_id: current_user.id)
  end

  def about
  end

  def news
  end

  def card_form
    @user = User.find(current_user.id)
  end

  def card_save
    @users = User.where(id: current_user.id)
    Payjp.api_key = PAYJP_SECRET_KEY
    customer = Payjp::Customer.create(card: params[:payjp_token])
    @users.update_all(token_id: params[:payjp_token], customer_id: customer.id)
    redirect_to add_card_users_path
  end

  def card_delete
    @users = User.find(current_user.id)
    Payjp.api_key = PAYJP_SECRET_KEY
    customer = Payjp::Customer.retrieve(@users.customer_id)
    customer.delete
    @users.update_attributes(token_id: nil, customer_id: nil)
    redirect_to :back
  end

  def add_card
    @user = User.find(current_user.id)
    @token = @user.token_id
    Payjp.api_key = PAYJP_SECRET_KEY
    if @token.present?
      @cards = Payjp::Token.retrieve(@token)
    end
  end
end

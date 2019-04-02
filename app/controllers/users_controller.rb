class UsersController < ApplicationController
before_action :user_default, :authenticate_user!, except:[:about, :news]
protect_from_forgery except: [:card_form, :card_save,:card_delete, :add_card]

  def show
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
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def edit_user
  end

  def history
    @favorite = Favorite.where(user_id: current_user.id)
  end

  private

  def user_default
    @user = User.find(current_user)
  end

  def user_params
    params.require(:user).permit(:image, :nickname).merge(id: current_user.id)
  end

  def read
    @tempfile.read
  end

end

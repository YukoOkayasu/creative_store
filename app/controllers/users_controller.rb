class UsersController < ApplicationController
before_action :authenticate_user!

  def show
    @user = User.find(current_user.id)
    @favorite = Favorite.where(user_id: current_user.id)
  end

  def about
  end

  def news
  end
end

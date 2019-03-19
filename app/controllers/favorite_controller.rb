class FavoriteController < ApplicationController
  def create
    @favorite = Favorite.create(user_id: current_user.id, product_id: params[:product_id])
    @favorite.save
  end

  def destroy
    @favorite = Favorite.find_by{user_id: current_user.id, product_id: params[:product_id]}
    @favorite.destroy
  end
end

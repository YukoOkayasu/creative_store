class FavoritesController < ApplicationController
  def create
    @favorite = Favorite.new(user_id: current_user.id, product_id: params[:product_id])
    @favorite.save
    @favorites = Favorite.where(product_id: params[:product_id])
    @products = Product.all
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, product_id: params[:product_id])
    @favorite.destroy
    @favorites = Favorite.where(product_id: params[:product_id])
    @products = Product.all
  end
end

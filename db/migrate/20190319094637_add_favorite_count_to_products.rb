class AddFavoriteCountToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :favorite_count, :integer
  end
end

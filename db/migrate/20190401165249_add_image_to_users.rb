class AddImageToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :image, :binary
  end
end

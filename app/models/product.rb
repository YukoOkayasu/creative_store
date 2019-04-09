class Product < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  has_many :cart_items
  belongs_to :category
  has_many :carts ,through: :cart_items
end

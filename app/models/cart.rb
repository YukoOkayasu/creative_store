class Cart < ApplicationRecord
  has_many :cart_items
  belongs_to :user
  has_many :products ,through: :cart_items
end

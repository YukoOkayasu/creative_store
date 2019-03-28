class Product < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  belongs_to :category
end

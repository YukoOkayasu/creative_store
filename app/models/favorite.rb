class Favorite < ApplicationRecord
  belongs_to :user, counter_cache: :favorite_count
  belongs_to :product
end

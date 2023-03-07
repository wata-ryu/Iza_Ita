class Genre < ApplicationRecord
  #アソシエーション
  has_many :posts, dependent: :destroy
end

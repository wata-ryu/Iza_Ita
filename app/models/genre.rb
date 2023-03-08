class Genre < ApplicationRecord
  #アソシエーション
  has_many :posts, dependent: :destroy
  
  #バリデーション、存在しなければならない
  validates :name, presence: true
end

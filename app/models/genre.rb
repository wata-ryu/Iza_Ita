class Genre < ApplicationRecord
  #アソシエーション
  #has_many :posts, dependent: :destroy
  
  #ジャンル検索機能のアソシエーション
  has_many :post_genres, dependent: :destroy
  has_many :posts, through: :post_genres, dependent: :destroy
  
  #バリデーション、存在しなければならない
  validates :name, presence: true
end

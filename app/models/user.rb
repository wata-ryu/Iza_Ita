class User < ApplicationRecord
  #アソシエーション
  has_many :bookmarks, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  #アクティブストレージで画像を取得できるようにする
  has_one_attached :profile_image
  
  #バリデーション設定、trueと記述するとデータが存在しなければならない
  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { in: 2..10 }
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

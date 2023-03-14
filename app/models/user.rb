class User < ApplicationRecord
  #アソシエーション
  has_many :bookmarks, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  #アクティブストレージで画像を取得できるようにする
  has_one_attached :profile_image
  
  #バリデーション設定、trueと記述するとデータが存在しなければならない
  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { in: 2..10 }
  validates :introduction, length: { maximum: 100 }
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  # 検索方法分岐
  def self.looks(search, word)
    #完全一致
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    #前方一致
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    #後方一致
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    #部分一致
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end
end
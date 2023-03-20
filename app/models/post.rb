class Post < ApplicationRecord
    #アクティブストレージで画像を取得できるようにする
    has_one_attached :image
    
    #アソシエーション
    has_many :bookmarks, dependent: :destroy
    has_many :comments, dependent: :destroy
    
    belongs_to :user
    
    #ジャンル検索機能のアソシエーション
    has_many :post_genres, dependent: :destroy
    has_many :genres, through: :post_genres, dependent: :destroy
    
    #バリデーション設定、trueと記述するとデータが存在しなければならない
    validates :title, presence: true, length: { in: 2..30 }
    validates :alcohol, presence: true, length: { in: 2..20 }
    validates :summary, presence: true, length: { in: 2..100 }
    validates :ingredient, presence: true, length: { in: 2..100 }
    validates :cook, presence: true, length: { in: 2..200 }
    validates :image, presence: true
    
    def bookmarked_by?(user)
      bookmarks.exists?(user_id: user.id)
    end
    
    # 検索方法分岐
    def self.looks(search, word)
      #完全一致
      if search == "perfect_match"
        @post = Post.where("title LIKE?","#{word}")
      #前方一致
      elsif search == "forward_match"
        @post = Post.where("title LIKE?","#{word}%")
      #後方一致
      elsif search == "backward_match"
        @post = Post.where("title LIKE?","%#{word}")
      #部分一致
      elsif search == "partial_match"
        @post = Post.where("title LIKE?","%#{word}%")
      
      else
        @post = Post.all
      end
    end
end

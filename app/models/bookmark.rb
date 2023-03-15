class Bookmark < ApplicationRecord
    #アソシエーション
    belongs_to :user
    belongs_to :post
    
    # バリデーション（ユーザーと記事の組み合わせは一意）同じ投稿を複数回お気に入り登録させないため。
    validates_uniqueness_of :post_id, scope: :user_id
end

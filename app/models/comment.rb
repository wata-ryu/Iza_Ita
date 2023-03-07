class Comment < ApplicationRecord
    #アソシエーション
    belongs_to :user
    belongs_to :post
    
    #バリデーション設定、trueと記述するとデータが存在しなければならない
    validates :comment, presence: true, uniqueness: { case_sensitive: false }, length: { in: 2..50 }
end

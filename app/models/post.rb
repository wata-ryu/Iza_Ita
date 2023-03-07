class Post < ApplicationRecord
    #アソシエーション
    has_many :bookmarks, dependent: :destroy
    has_many :comments, dependent: :destroy
    belongs_to :user
    belongs_to :genre
    
    #アクティブストレージで画像を取得できるようにする
    has_one_attached :image
    
    #バリデーション設定、trueと記述するとデータが存在しなければならない
    validates :title, presence: true, uniqueness: { case_sensitive: false }, length: { in: 2..30 }
    validates :alcohol, presence: true, uniqueness: { case_sensitive: false }, length: { in: 2..20 }
    validates :summary, presence: true, uniqueness: { case_sensitive: false }, length: { in: 2..100 }
    validates :ingredient, presence: true, uniqueness: { case_sensitive: false }, length: { in: 2..100 }
    validates :cook, presence: true, uniqueness: { case_sensitive: false }, length: { in: 2..200 }
    validates :image, presence: true
    
    #画像が設定されない場合はapp/assets/imagesに格納されているno_image.jpgという画像をデフォルト画像としてActiveStorageに格納し、格納した画像を表示する。
    def get_image
      unless image.attached?
        file_path = Rails.root.join('app/assets/images/no_image.jpg')
        image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
      image
    end
end

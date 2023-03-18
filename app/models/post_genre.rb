class PostGenre < ApplicationRecord
  #rails generate model Book_tag book:references tag:referencesで↓が自動で作成される
  belongs_to :post
  belongs_to :genre
end

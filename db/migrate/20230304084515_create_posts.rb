class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.integer :genre_id,null: false
      t.string  :title,   null: false
      t.string  :alcohol,   null: false
      t.string  :summary,   null: false
      t.string  :ingredient,   null: false
      t.text    :cook,   null: false
      t.boolean  :release,   null: false, default: "false"
      
      t.timestamps
    end
  end
end

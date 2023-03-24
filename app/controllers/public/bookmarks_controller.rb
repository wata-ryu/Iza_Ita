class Public::BookmarksController < ApplicationController
  
  def index
  end

  def create
    post = Post.find(params[:post_id])
    bookmark = current_user.bookmarks.new(post_id: post.id)
    bookmark.save
    redirect_to public_post_path(post)
  end

  def destroy
    post = Post.find(params[:post_id])
    bookmark = current_user.bookmarks.find_by(post_id: post.id)
    bookmark.destroy
    redirect_to public_post_path(post)
  end
  
  private
  #ストロングパラメータ
  def bookmark_params
    params.require(:bookmark).permit(:user_id, :post_id)
  end
end

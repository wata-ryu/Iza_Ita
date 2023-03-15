class Public::BookmarksController < ApplicationController
  def index
    @genres = Genre.all
    #ジャンル検索機能および全体一覧
    @posts = params[:name].present? ? Genre.find(params[:name]).posts : Post.all.order("created_at DESC")
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

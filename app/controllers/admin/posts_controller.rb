class Admin::PostsController < ApplicationController
  def index
    @genres = Genre.all
    #ジャンル検索機能および全体一覧
    @posts = params[:name].present? ? Genre.find(params[:name]).posts : Post.all.order("created_at DESC")
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user.id)
    @comment = Comment.new
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to public_posts_path
  end
  
  private
  #ストロングパラメータ
  def post_params
    params.require(:post).permit(:title, :alcohol, :summary, :ingredient, :cook, :image, :release, :genre_id, genre_ids: [] )
  end
end

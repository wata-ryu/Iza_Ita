class Public::CommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to public_post_path(post)
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      redirect_to public_post_path(params[:post_id])
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end

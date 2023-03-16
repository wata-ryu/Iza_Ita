class Admin::CommentsController < ApplicationController
  
  def destroy
    byebug
    Comment.find(params[:id]).destroy
    redirect_to admin_posts_path(params[:post_id])
  end
  
  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end

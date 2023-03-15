class Admin::UsersController < ApplicationController
  
  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
  end

  def update
  end
  
  def unsubscribe
    #退会機能、adminが強制退会させるときはユーザーidを含める
    @user = User.find(params[:user_id])
  end

  def withdraw
    #退会機能、adminが強制退会させるときはユーザーidを含める
    @user = User.find(params[:user_id])
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    #論理削除は、アソシエーションでは消えないので、消したいものにdestroy_allをやる！
    @user.posts.destroy_all
    @user.comments.destroy_all
    @user.bookmarks.destroy_all
    flash[:notice] = "強制退会させました( ´Д`)y━･~~"
    redirect_to admin_users_path
  end
  
  private
  # ストロングパラメータ 基本削ることはない
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end

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

  def withdraw
  end
  
  private
  # ストロングパラメータ 基本削ることはない
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end

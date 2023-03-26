class SearchesController < ApplicationController

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "User"
      #検索対象モデルがUserの時、admin用
      @users_admin = User.looks_for_admin(params[:search], params[:word]).page(params[:page])
      #検索対象モデルがUserの時、user用
      @users = User.looks(params[:search], params[:word]).page(params[:page])
    else
      #タイトルの時
      @posts = Post.looks(params[:search], params[:word]).page(params[:page])
    end
  end
end

class SearchesController < ApplicationController
  #user,admin共通検索機能
  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "User"
      #検索対象モデルがUserの時、admin用（退会ユーザー含む全て表示 + 最新を上に表示 + kaminariでのページネーション）
      @users_admin = User.looks_for_admin(params[:search], params[:word]).order("created_at DESC").page(params[:page])
      #検索対象モデルがUserの時、user用（退会ユーザーは表示しない + 最新を上に表示 + kaminariでのページネーション）
      @users = User.looks(params[:search], params[:word]).order("created_at DESC").page(params[:page])
    else
      #タイトルの時（公開設定した投稿のみ表示 + 最新を上に表示 + kaminariでのページネーション）
      @posts = Post.released.looks(params[:search], params[:word]).order("created_at DESC").page(params[:page])
    end
  end
end

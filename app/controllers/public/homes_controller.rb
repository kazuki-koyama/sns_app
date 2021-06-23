class Public::HomesController < ApplicationController
  before_action :authenticate_user!, except: [:top]

  def top
    # 管理者側でログインしている場合はログアウトする
    if admin_signed_in?
      sign_out_and_redirect(current_admin)
      flash[:warning] = '管理者側サイトはログアウトしました'
    end
    # ユーザー側でログインしている場合はホーム画面へ移動
    return unless user_signed_in?
    flash[:notice] = 'ログイン済みです'
    redirect_to home_path
  end

  def home
    @posts = current_user.feed.includes(:user).order(created_at: :desc).page(params[:page]).without_count.per(10)
  end
end

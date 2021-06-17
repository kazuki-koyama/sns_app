class Public::HomesController < ApplicationController
  def top
  end

  def home
    @posts = current_user.feed.includes(:user, :comments).order(created_at: :desc).page(params[:page]).without_count.per(10)
  end
end

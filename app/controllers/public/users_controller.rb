class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :favorites]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).without_count.per(10)
  end

  def index
    # おすすめユーザーから自分とゲストユーザーを除外
    recommend_users = User.where.not(id: current_user.id).where.not(email: 'guest@example.com')
    @users = recommend_users.order(created_at: :desc).page(params[:page]).without_count.per(15)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      sleep(3) # S3への画像反映のタイムラグを考慮して3秒待機
      redirect_to user_path(@user), notice: "プロフィールを更新しました"
    else
      render "edit"
    end
  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: current_user.id).pluck(:post_id)
    @favorite_posts = Kaminari.paginate_array(Post.includes(:user).order(created_at: :desc).find(favorites)).page(params[:page]).per(20)
  end

  def unsubscribe
  end

  def withdraw
    user = current_user
    if user.email == 'guest@example.com'
      # ゲストユーザーは退会させず、プロフィールを初期化
      user.name = 'ゲストユーザー'
      user.is_valid = true
      user.introduction = 'よろしくお願いします。'
      user.profile_image_id = nil
    else
      # 一般ユーザーは退会させる
      user.is_valid = false
    end
    user.save
    reset_session
    redirect_to root_path, notice: 'ありがとうございました。またのご利用を心よりお待ちしております。'
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end

class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :favorites]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).without_count.per(10)
  end

  def index
    @users = User.all.order(created_at: :desc).page(params[:page]).without_count.per(15)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "Updated successfully"
    else
      render "edit"
    end
  end

  def favorites
    @user = User.find(params[:id])
    favorites = Favorite.where(user_id: current_user.id).pluck(:post_id)
    @favorite_posts = Kaminari.paginate_array(Post.includes(:user).find(favorites)).page(params[:page]).per(20)
  end

  def unsubscribe
  end

  def withdraw
    current_user.update(is_vaild: false)
    reset_session
    redirect_to root_path
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

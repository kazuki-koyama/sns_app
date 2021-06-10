class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :favorites]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @comment = Comment.new
  end

  def index
    @users = User.all.order(created_at: :desc)
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
    @favorite_posts = Post.find(favorites)
    @comment = Comment.new
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

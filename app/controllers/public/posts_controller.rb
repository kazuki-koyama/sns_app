class Public::PostsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path, notice: "新しい投稿が作成されました"
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def index
    @posts = Post.all
  end

  def update
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:before_image, :after_image, :caption)
  end

  def ensure_correct_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to posts_path
    end
  end
end

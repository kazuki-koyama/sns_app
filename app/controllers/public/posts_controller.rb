class Public::PostsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      @status = "success"
    else
      @status = "fail"
    end
  end

  def show
    @post = Post.includes(:user).find(params[:id])
    @user = @post.user
    respond_to do |format|
      format.html
      format.js
    end
  end

  def index
    @posts = Post.includes(:user).order(created_at: :desc).page(params[:page]).without_count.per(10)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    if @post.update(post_params)
      sleep(3) # S3への画像反映のタイムラグを考慮して3秒待機
      redirect_to post_path(@post), notice: "投稿を更新しました"
    else
      render "edit"
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  def hashtag
    @hashtag = Hashtag.find_by(hashname: params[:name])
    @posts = @hashtag.posts.order(created_at: :desc).page(params[:page]).without_count.per(10)
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

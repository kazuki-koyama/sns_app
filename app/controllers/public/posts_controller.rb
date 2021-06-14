class Public::PostsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @comment = Comment.new
    @post = current_user.posts.new(post_params)
    if @post.save
      @status = "success"
    else
      @status = "fail"
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def index
    @posts = Post.order(created_at: :desc).page(params[:page]).without_count.per(10)
    @comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: "updated post successfully"
    else
      render "edit"
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  def hashtag
    @user = current_user
    @hashtag = Hashtag.find_by(hashname: params[:name])
    @posts = @hashtag.posts
    @comment = Comment.new
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

class Public::PostsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @comment = Comment.new
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      @status = "success"
    else
      @status = "fail"
    end
  end

  def index
    @posts = Post.all.order(created_at: :desc)
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
    @tag = Hashtag.find_by(hashname: params[:name])
    @posts = @tag.posts
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

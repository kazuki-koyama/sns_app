class Public::LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @post.create_notification_like!(current_user)
    like = @post.likes.new(user_id: current_user.id)
    like.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = @post.likes.find_by(user_id: current_user.id)
    like.destroy
  end
end

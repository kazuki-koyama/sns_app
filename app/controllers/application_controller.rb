class ApplicationController < ActionController::Base
  before_action :set_post
  before_action :set_users

  def set_post
    @post = Post.new
  end

  def set_users
    @users = User.all.order(created_at: :desc).first(5)
  end
end

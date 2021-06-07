class ApplicationController < ActionController::Base
  before_action :set_post

  def set_post
    @post = Post.new
  end
end

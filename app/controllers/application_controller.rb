class ApplicationController < ActionController::Base
  before_action :set_users

  def set_users
    if user_signed_in?
      recommend_users = User.where.not(id: current_user.id).where.not(email: 'guest@example.com')
      @users = recommend_users.order(created_at: :desc).first(5)
    end
  end
end

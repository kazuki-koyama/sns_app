class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!

	def create
	  @user = User.find(params[:user_id])
		current_user.follow(@user)
		respond_to do |format|
		  format.html { redirect_to @user }
		  format.js
		end
	end

	def destroy
    @user = User.find(params[:user_id])
		current_user.unfollow(@user)
		respond_to do |format|
		  format.html { redirect_to @user }
		  format.js
		end
	end

  def followings
		user = User.find(params[:user_id])
		@users = user.followings
  end

  def followers
		user = User.find(params[:user_id])
		@users = user.followers
  end
end
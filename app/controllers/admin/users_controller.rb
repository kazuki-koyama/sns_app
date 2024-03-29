class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.page(params[:page]).reverse_order.per(15)
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "Updated successfully"
    else
      render "show"
    end
  end

  private

  def user_params
    params.require(:user).permit(:is_valid)
  end
end

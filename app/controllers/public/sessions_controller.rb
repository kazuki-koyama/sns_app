# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :reject_inactive_user, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to home_path, notice: 'ゲストユーザーとしてログインしました'
  end

  protected

  def after_sign_in_path_for(resource)
    home_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  # 退会したユーザーがログインできないようにする
  def reject_inactive_user
    @user = User.find_by(email: params[:user][:email])
    if @user
      if @user.valid_password?(params[:user][:password]) && !@user.is_valid
        flash[:danger] = "このアカウントは退会済みです。恐れ入りますが、別のメールアドレスをお使いください。"
        redirect_to new_user_session_path
      end
    end
  end
end

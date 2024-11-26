# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  before_action :user_state, only: [:create]

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

  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end

  def guest_sign_in
    guest_user = User.find_or_create_by(email: 'guest@example.com',name: "guest_user",age: "25") do |user|
      user.password = SecureRandom.hex(10) 
      user.password_confirmation = user.password
    end

    sign_in guest_user
    redirect_to logs_path, notice: 'ゲストユーザーとしてログインしました'
  end

  private

  def user_state
    return if current_user&.email == 'guest@example.com'

    user = User.find_by(email: params[:user][:email])
    return if user.nil?
    return unless user.valid_password?(params[:user][:password])
  end


  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end

class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:guest_sign_in]
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :prevent_guest_user, only: [:update, :withdraw]

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    unless @user
      redirect_to root_path, alert: "ユーザーが見つかりませんでした"
    end
    @logs = @user.logs
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if current_user.email == 'guest@example.com'
      flash[:alert] = 'ゲストユーザーは情報を変更できません'
      redirect_to user_path(@user) and return
    end

    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def unsubscribe
    @user = current_user
  end

  def withdraw
    @user = current_user
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to new_user_registration_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :age, :gender, :email, :password, :password_confirmation)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to logs_path
    end
  end

  def prevent_guest_user
    if current_user.email == 'guest@example.com'
      flash[:alert] = 'ゲストユーザーはこの操作を行うことができません'
      redirect_to user_path(current_user)
    end
  end
  
end

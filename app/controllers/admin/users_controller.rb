class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :prevent_guest_user, only: [:update] 
  
  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find_by(id: params[:id])
    unless @user
      redirect_to admin_users_path, alert: "ユーザーが見つかりませんでした"
    end
    @logs = @user.logs
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.email == 'guest@example.com'
      flash[:alert] = 'ゲストユーザーの情報は更新できません'
      redirect_to admin_user_path(@user) and return
    end

    if @user.update(user_params)
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :age, :gender, :is_active)
  end

  def prevent_guest_user
    user = User.find(params[:id])
    if user.email == 'guest@example.com'
      flash[:alert] = 'ゲストユーザーの情報は更新できません'
      redirect_to admin_user_path(user)  # 更新が禁止されたユーザーの詳細ページにリダイレクト
    end
  end

end

class Public::LogsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  
  def new
    @log = Log.new
  end

  def create
    @log = Log.new(log_params)
    @log.user_id = current_user.id
    if @log.save
      redirect_to log_path(@log.id)
    else
      render :new
    end
  end

  def index
    @logs = Log.page(params[:page])
  end

  def show
    @log = Log.find_by(id: params[:id])
    unless @log
      redirect_to logs_path, alert: 'ログが見つかりませんでした'
    end
  end

  def edit
    @log = Log.find_by(id: params[:id])
    unless @log
      redirect_to logs_path, alert: 'ログが見つかりませんでした'
    end
  end

  def update
    @log = Log.find_by(id: params[:id])
    unless @log
      redirect_to logs_path, alert: 'ログが見つかりませんでした'
    end
    if @log.update(log_params)
      redirect_to log_path(@log.id), notice: 'ログが更新されました'
    else
      render :edit
    end
  end

  def destroy
    @log = Log.find_by(id: params[:id])
    unless @log
      redirect_to logs_path, alert: 'ログが見つかりませんでした'
    end
    @log.destroy
    redirect_to logs_path, notice: 'ログが削除されました'
  end

  private

  def log_params
    params.require(:log).permit(:title, :body, :location, :date, :price, :public_order, :meal, :image)
  end

  def is_matching_login_user
    @log = Log.find_by(id: params[:id])
    unless @log && @log.user_id == current_user.id
      redirect_to logs_path, alert: 'あなたはこのログを編集できません。'
    end
  end

end

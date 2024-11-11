class Admin::LogsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @logs = Log.page(params[:page])
  end

  def show
    @log = Log.find(params[:id])
    unless @log
      redirect_to admin_logs_path, alert: 'ログが見つかりませんでした'
    end
  end

  def destroy
    @log = Log.find_by(id: params[:id])
    unless @log
      redirect_to logs_path, alert: 'ログが見つかりませんでした'
    end
    @log.destroy
    redirect_to admin_logs_path, notice: 'ログが削除されました'
  end

  private

  def log_params
    params.require(:log).permit(:title, :body, :location, :date, :price, :public_order, :meal, :image)
  end
  
end

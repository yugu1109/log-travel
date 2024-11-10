class Admin::LogsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @logs = Log.page(params[:page])
  end

  def show
    @log = Log.find(params[:id])
  end

  def destroy
    @log = Log.find(params[:id])
  	@log.destroy
  	redirect_to admin_logs_path
  end

  private

  def log_params
    params.require(:log).permit(:title, :body, :location, :date, :price, :public_order, :meal)
  end
  
end

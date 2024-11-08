class Public::LogsController < ApplicationController
  
  def new
    @log = Log.new
  end

  def create
    @log = Log.new(log_params)
    @log.save
    redirect_to log_path(@log.id)
  end

  def index
    @logs = Log.page(params[:page])
  end

  def show
    @log = Log.find(params[:id])
  end

  def edit
    @log = Log.find(params[:id])
  end

  def update
    @log = Log.find(params[:id])
    if @log.update(log_params)
     redirect_to log_path(@log.id)
    else
     render :edit
    end
  end

  def destroy
    @log = Log.find(params[:id])
  	@log.destroy
  	redirect_to logs_path
  end

  private

  def log_params
    params.require(:log).permit(:title, :body, :location, :date, :price, :public_order, :meal)
  end

end

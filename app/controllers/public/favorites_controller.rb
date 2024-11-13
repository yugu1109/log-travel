class Public::FavoritesController < ApplicationController

  def create
    log = Log.find(params[:log_id])
    favorite = current_user.favorites.new(log_id: log.id)
    favorite.save
    redirect_to log_path(log)
  end

  def destroy
    log = Log.find(params[:log_id])
    favorite = current_user.favorites.find_by(log_id: log.id)
    favorite.destroy
    redirect_to log_path(log)
  end

end

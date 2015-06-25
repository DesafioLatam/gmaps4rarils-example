class UsersController < ApplicationController
  before_filter :authenticate_user!, except: :address

  def index
    @users = User.all
    @hash = Gmaps4rails.build_markers(@users.where.not(latitude:nil)) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
    end
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to :back, :alert => "Access denied."
    end
  end

  def address
    query = params[:latitude] + "," + params[:longitude]
    result = Geocoder.search(query).first
    pp result.to_json 
    @result = result.formatted_address
    respond_to do |f|
      f.js
    end
  end

end

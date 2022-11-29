class TripsController < ApplicationController
  def index
    @trips = Trip.all
    @new_trip = Trip.new
  end

  def show
    @trip = Trip.find(params[:id])
  end

  def update
    @trip = Trip.find(params[:id])
  end

  def destroy
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user = current_user
    @trip.save
  end

  private

  def trip_params
    params.require(:trip).permit(:name, :description, :start_date, :end_date)
  end

end

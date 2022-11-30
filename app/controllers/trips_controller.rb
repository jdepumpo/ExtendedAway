class TripsController < ApplicationController

  def index
    @trips = Trip.all
    @new_trip = Trip.new
  end

  def show
    @trip = Trip.find(params[:id])
    @task = Task.new
    @categories = Category.all
  end

  def update
    @trip = Trip.find(params[:id])
  end

  def destroy
    @trip = Trip.find(params[:id])
    if @trip.destroy
      redirect_to trips_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user = current_user
    @trip.save
    if @trip.save
      redirect_to trips_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:name, :description, :start_date, :end_date)
  end

end

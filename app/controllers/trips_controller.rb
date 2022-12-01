class TripsController < ApplicationController

  def index
    @trips = Trip.where(user_id: current_user.id)
    @new_trip = Trip.new
  end

  def show
    @trip = Trip.find(params[:id])
    @task = Task.new
    @categories = Category.all
    caretaker_array = []
    @trip.tasks.each do |task|
      caretaker_array << task.user
    end
    @caretakers = caretaker_array.uniq
  end

  def update
    @trip = Trip.find(params[:id])
    @trip.update(trip_params)
    if @trip.save
      redirect_to trips_path
    else
      render :index, status: :unprocessable_entity
    end
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

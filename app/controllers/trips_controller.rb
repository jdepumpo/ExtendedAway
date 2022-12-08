class TripsController < ApplicationController

  def index
    case current_user.role
    when "homeowner"
      @trips = Trip.where(user_id: current_user.id)
    when "caretaker"
      task_array = []
      Task.where(user_id: current_user.id).each { |task| task_array << task.trip }
      @trips = task_array.uniq
    else
      @trips = []
      "no trips yet"
    end
    @picture_array = ["https://images.pexels.com/photos/2356059/pexels-photo-2356059.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2", "https://images.pexels.com/photos/208701/pexels-photo-208701.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2", "https://images.pexels.com/photos/1285625/pexels-photo-1285625.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2", "https://images.pexels.com/photos/176395/pexels-photo-176395.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2", "https://images.pexels.com/photos/209878/pexels-photo-209878.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"]
  end

  def new
    @trip = Trip.new
  end

  def show
    @trip = Trip.find(params[:id])
    @task = Task.new
    @dates = ((Date.new(@trip.start_date.year, @trip.start_date.month, @trip.start_date.day))..(Date.new(@trip.end_date.year, @trip.end_date.month, @trip.end_date.day))).to_a
    @categories = Category.all
    caretaker_array = []
    @trip.tasks.each do |task|
      caretaker_array << task.user
    end
    @caretakers = caretaker_array.uniq
    case current_user.role
    when "homeowner"
      @tasks = @trip.tasks
    when "caretaker"
      @tasks = @trip.tasks.where(user_id: current_user)
    end
    @picture_array = ["https://images.pexels.com/photos/2356059/pexels-photo-2356059.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2", "https://images.pexels.com/photos/208701/pexels-photo-208701.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2", "https://images.pexels.com/photos/1285625/pexels-photo-1285625.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2", "https://images.pexels.com/photos/176395/pexels-photo-176395.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2", "https://images.pexels.com/photos/209878/pexels-photo-209878.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"]
  end

  def edit
    @trip = Trip.find(params[:id])
  end

  def update
    @trip = Trip.find(params[:id])
    @trip.update(trip_params)
    if @trip.save
      redirect_to trip_path(@trip)
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
      redirect_to trip_path(@trip)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def trip_params
    params.require(:trip).permit(:name, :description, :start_date, :end_date, :location, :entry_description, :entry_type, :entry_key, :photo)
  end
end

class TasksController < ApplicationController
  def create
    @trip = Trip.find(params[:trip_id])
    @task = Task.new(task_params)
    @task.trip = @trip
    @task.user = current_user
    @task.category = Category.find(params[:task][:category])
    if @task.save
      redirect_to trip_path(@trip)
    else
      render "trips/show", status: :unprocessable_entity
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @trip = @task.trip

    @task.done = !@task.done

    if @task.save
      redirect_to trip_path(@trip)
    else
      render "trips/show", status: :unprocessable_entity
    end
  end

  def set_caretaker
    @trip = Trip.find(params[:trip_id])
    @tasks = @trip.tasks.where(date: params[:date])
    @tasks.each do |task|
      task.user = params[:user]
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @trip = @task.trip
    @task.destroy
    redirect_to trip_path(@trip), status: :see_other
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :date)
  end
end

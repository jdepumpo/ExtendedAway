class TasksController < ApplicationController
  def create
    @trip = Trip.find(params[:id])
    @task = Task.new(task_params)
    @task.save
    redirect_to trip_path(@trip)
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :done, :repeat_every)
  end
end

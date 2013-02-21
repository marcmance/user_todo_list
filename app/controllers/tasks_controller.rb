class TasksController < ApplicationController
  def update
    @task = Task.find(params[:id])
    @task.update_attributes(:completed => true)
    @task.save
    redirect_to current_user
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to current_user
  end

end

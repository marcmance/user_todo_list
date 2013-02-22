class TasksController < ApplicationController

  def create
    user = User.find(params[:task][:hidden])
    task = Task.new(:user_id => params[:task][:hidden], :description => params[:task][:description])
    task.save
    redirect_to current_user
  end

  def update
    @task = Task.find(params[:id])
    @task.update_attributes(:completed => true)
    redirect_to current_user
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to current_user
  end

  def uncomplete_task
    @task = Task.find(params[:id])
    @task.update_attributes(:completed => false)
    redirect_to current_user
  end

  def update_all_tasks
    @tasks =  User.find(params[:task][:hidden]).tasks.not_completed

    params[:task].each do |k,v|
      if @tasks.exists?(:id => k)
        t = @tasks.find(k)
        t.update_attributes(:description => v)
      end
    end
    redirect_to current_user
  end

end

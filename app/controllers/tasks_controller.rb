class TasksController < ApplicationController
  def create
    @task = Task.new
  end

end

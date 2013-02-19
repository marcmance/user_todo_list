class TasksController < ApplicationController
  def user_tasks
    @user = User.find(3)
  end

end

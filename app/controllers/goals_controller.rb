class GoalsController < ApplicationController
  
  before_action :must_be_logged_in
  
  def index
    @goals = Goal.where("user_id = #{current_user.id} OR private = ?", false)
  end
  
  def show
    @goal = Goal.find(params[:id])
  end
  
  def new
    @goal = Goal.new
  end
  
  def create
    @goal = current_user.goals.new(goal_params)
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end
  
  def update
    @goal = Goal.find(params[:id])
    if @goal.update_attributes(goal_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end
  
  def edit
    @goal = Goal.find(params[:id])
  end
  
  def destroy
    Goal.find(params[:id]).destroy
    redirect_to goals_url
  end
  
  private 
  def goal_params
    params.require(:goal).permit(:title, :completed)
  end
end

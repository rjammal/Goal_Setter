class SessionsController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.find_by_credentials(user_params[:username], user_params[:password])
    if @user
      login!(@user)
      redirect_to goals_url
    else
      @user = User.new(user_params)
      flash.now[:errors] = ["Invalid credentials."]
      render :new
    end
  end
  
  def destroy
    logout!
    redirect_to new_session_url
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end

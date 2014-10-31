class SessionsController < ApplicationController
  
  def new
    @user = User.new
    
    render :new
  end
  
  def create
    @user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
    
    if @user
      login_user!(@user)
      redirect_to subs_url
    else
      flash.now[:errors] = "Incorrect username/password combination"
      @user = User.new(user_name: params[:user][:user_name])
      render :new
    end
    
  end
  
  def destroy
    @user = current_user
    
    @user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_user_url
  end
  
end

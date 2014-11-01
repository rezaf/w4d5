class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :logged_in?
  helper_method :current_user
  
  def login_user!(user)
    session[:session_token] = user.reset_session_token!
  end
  
  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by_session_token(session[:session_token])
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  def verify_moderator
    unless Sub.find(params[:id]).moderator_id == current_user.id
      flash[:errors] = "Must be moderator of this sub to edit"
      redirect_to subs_url 
    end
  end
  
  def verify_author
    post = Post.find(params[:id])
    post_sub = post.sub
    
    unless post.author_id == current_user.id
      flash[:errors] = "Must be author of this post to edit"
      redirect_to sub_url(post_sub) 
    end
  end
end

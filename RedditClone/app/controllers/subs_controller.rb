class SubsController < ApplicationController
  before_action :verify_moderator, only: [:edit, :update, :destroy]
  
  def new
    @user = User.find(params[:user_id])
    @sub = Sub.new
    
    render :new
  end
  
  def create
    @sub = Sub.new(sub_params)
    
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end 
  end
  
  def show
    @sub = Sub.find(params[:id])
    @posts = @sub.sub_posts
    
    render :show
  end
  
  def index
    @subs = Sub.all
    
    render :index
  end
  
  def destroy
    @sub = Sub.find(params[:id])
    
    @sub.destroy
  end
  
  def update
    @sub = Sub.find(params[:id])
    
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
    
  end
  
  def edit
    @sub = Sub.find(params[:id])
    
    render :edit
  end
  
  private
  
  def sub_params
    params.require(:sub).permit(:title, :description, :moderator_id)
  end
  
end

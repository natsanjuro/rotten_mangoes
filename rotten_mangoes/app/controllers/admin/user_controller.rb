class Admin::UserController < ApplicationController

  before_filter :admin?

  def admin?
    return if current_session(:admin_user_id)
    unless current_user && current_user.admin
      redirect_to movies_path
    end
  end  

  def index
    @users = User.all.page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: "New user #{@user.firstname + @user.lastname} created"
    else
      render :new
    end    
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end  

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to admin_users_path, notice: "#{@user.firstname + @user.lastname} has been updated"
    else
      render :new  
    end 
  end   

    def destory
      @user = User.find(params[:id])
      @user.destory
      redirect_to admin_users_path, notice: "#{@user.firstname + @user.lastname} has been deleted"
    end  
  
  end  


end

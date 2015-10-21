class Admin::UsersController < ApplicationController

  before_action :admin_only

  def index
    @users = User.all.page(params[:page]).per(10)
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

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    UserMailer.goodbye_email(@user).deliver
    redirect_to admin_users_path, notice: "#{@user.firstname + @user.lastname} has been deleted"
  end  

  private

  def admin_only
  unless current_user.admin
    flash[:alert] = "Admin only"
    redirect_to root_path
    end
  end

   protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
  end  
  
end  


# def admin?
  #   return if current_session(:admin_user_id)
  #   unless current_user && current_user.admin
  #     redirect_to movies_path
  #   end
  # end  

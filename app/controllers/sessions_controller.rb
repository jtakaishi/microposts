class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:info] = "ようこそ　#{@user.name}さん"
      redirect_to @user
    else
      flash[:danger] = 'emailまたはpasswordが間違っています'
      render 'new'
    end
  end
  
  def edit
  end

  def update
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end

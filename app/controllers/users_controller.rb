class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  before_action :logged_in_user, only: [:edit, :update, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc).page(params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Sample Appへようこそ！"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      # 保存に成功した場合は成功メッセージ
      flash[:success] = "Profileを更新しました"
      redirect_to(:back)
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following_users.paginate(page: params[:page])
    render 'show_follow'
  end
    
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.follower_users.paginate(page: params[:page])
    render 'show_follow'  
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :region, :password_confirmation)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end
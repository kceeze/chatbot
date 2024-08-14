class UsersController < ApplicationController
  before_action :get_user, only: [:show, :edit, :update, :destroy]
  before_action :require_signin, except: [:create, :new]
  
  def index 
    @users = User.all
  end

  def show
 
  end

  def edit

  end

  def update
    if @user.save
      redirect_to @user
    else
      render :edit, status: unprocessable_entity
    end

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def get_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :password, :email)
  end
end

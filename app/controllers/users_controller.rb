class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :find_user, only: [:show, :edit, :update]

  def index
    @users = User.paginate page: params[:page]
  end

  def show
    @activities = @user.activities.order_by_time.paginate page: params[:page]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t :welcome
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t :profile_updated
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :avatar
  end

  def find_user
    @user = User.find_by_id params[:id]
    if @user.nil?
      redirect_to root_path
      flash[:danger] = t :user_fails
    end
  end
end

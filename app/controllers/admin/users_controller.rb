class Admin::UsersController < ApplicationController
  before_action :require_admin

  def index
    @users = User.paginate page: params[:page]
  end

  def destroy
    user = User.find_by id: params[:id]
    
    if user.nil?
      flash[:success] = t :delete_fail 
    else
      if current_user? user
        flash[:success] = t :delete_self
      else
        user.destroy
        flash[:success] = t :destroy_sucess
      end
    end
    redirect_to admin_users_path
  end
end

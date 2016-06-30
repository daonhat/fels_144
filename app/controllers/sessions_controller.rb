class SessionsController < ApplicationController
  def new
    redirect_to root_url if logged_in?
  end

  def create
    user = User.find_by email: params[:session][:email].downcase 
    if user && user.authenticate(params[:session][:password])
      log_in user
      current_user.create_activity "login"
      user.is_admin? ? redirect_to(admin_root_path) : redirect_to(root_path)
    else
      flash.now[:danger] = t :login_fails
      render :new
    end
  end

  def destroy
    if logged_in?
      current_user.create_activity "logout"
      log_out
    end
    redirect_to root_url
  end
end

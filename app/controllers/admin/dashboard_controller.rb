class Admin::DashboardController < ApplicationController
  layout "admin/application"
  before_action :require_admin
  
  def index
    @users = User.all
    @words = Word.all
  end
end

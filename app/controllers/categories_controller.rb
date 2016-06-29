class CategoriesController < ApplicationController
  before_action :logged_in_user, only: [:index, :show]
  
  def index
    @categories = Category.order(created_at: :desc)
      .paginate(page: params[:page]).per_page Settings.page_size
  end

  def show
    @category = Category.find_by_id params[:id]
    @words = @category.words
    @words = @category.words.order("content #{sort_direction}").
      paginate(page: params[:page]).per_page Settings.page_size
  end

  private
  def sort_direction
    Settings.filter.include?(params[:direction]) ? params[:direction] : "asc"
  end
end

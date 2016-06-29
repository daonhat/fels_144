class Admin::CategoriesController < ApplicationController
  layout "admin/application"
  before_action :require_admin
  before_action :find_category, except: [:index, :new, :create]

  def index
    @categories = Category.paginate(page: params[:page]).per_page Settings.page_size
  end

  def show
    @words = @category.words
    @words = @words.order("content " + sort_direction).
      paginate(page: params[:page]).per_page Settings.page_size
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t :created_category
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t :category_updated
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_path
  end

  private
  def category_params
    params.require(:category).permit :title, :description
  end

  def find_category
    @category = Category.find_by_id params[:id]
    if @category.nil?
      flash[:danger] = t :category_fails
      redirect_to admin_categories_path
    end
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end

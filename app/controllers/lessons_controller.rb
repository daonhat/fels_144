class LessonsController < ApplicationController
  before_action :logged_in_user, only: [:show, :create]
  before_action :find_lesson, only: [:show, :update]

  def show   
  end

  def create
    @lesson = current_user.lessons.new lesson_params
    if @lesson.save
      flash[:success] = t :created_lesson
      redirect_to @lesson
    else
      flash[:danger] = t :lesson_not_create
      redirect_to categories_path
    end
  end

  def update
    if @lesson.update_attributes lesson_params
      flash[:success] = t :lesson_success
    else
      flash[:danger] = t :lesson_fails
    end
    redirect_to lesson_path @lesson
  end

  private
  def lesson_params
    params.require(:lesson).permit :category_id,
      results_attributes: [:id, :word_answer_id]
  end

  def find_lesson
    @lesson = Lesson.find_by id: params[:id]
    if @lesson.nil?
      redirect_to root_path
      flash[:danger] = t :lesson_fails
    end
  end
end

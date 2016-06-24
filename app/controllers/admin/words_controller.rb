class Admin::WordsController < ApplicationController
  before_action :require_admin
  before_action :find_word, except: [:index, :new, :create]

  def index
    @words = Word.paginate page: params[:page]
  end
  
  def show
  end

  def new
    @categories = Category.all
    @word = Word.new
    Settings.number_of_answers.times {@word.word_answers.build}
  end

  def create
    @word = Word.new word_params
    if @word.save
      flash[:success] = t :created_word
      redirect_to admin_word_path(@word)
    else
      @categories = Category.all
      render :new
    end
  end

  def edit
  end

  def update
    if @word.update_attributes word_params
      flash[:success] = t :word_updated
      redirect_to admin_word_path @word
    else
      render :edit
   end
  end

  def destroy
    @word.destroy
    flash[:success] = t :destroy_sucess
    redirect_to admin_words_path
  end

  private
  def word_params
    params.require(:word).permit :content, :category_id,
      word_answers_attributes: [:id, :content, :is_correct, :_destroy]
  end
  def find_word
    @word = Word.find_by_id params[:id]
    if @word.nil?
      flash[:danger] = t :word_fails
      redirect_to admin_words_path
    end
  end
end

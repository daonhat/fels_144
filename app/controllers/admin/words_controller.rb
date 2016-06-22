class Admin::WordsController < ApplicationController
  def new
    @categories = Category.all
    @word = Word.new
    Settings.number_of_answers.times {@word.word_answers.build}
  end

  def create
    @word = Word.new word_params
    if @word.save
      flash[:success] = t :created_word
      redirect_to new_admin_word_path
    else
      @categories = Category.all
      render :new
    end
  end

  private
  def word_params
    params.require(:word).permit :content, :category_id,
      word_answers_attributes: [:content, :is_correct]
  end
end

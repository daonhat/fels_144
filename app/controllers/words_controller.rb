class WordsController < ApplicationController
  before_action :logged_in_user, only: :index

  def index
    @categories = Category.all
    @words = if params[:category_id].nil? ||
      params[:category_id].empty? && params[:word_type].nil?
      params[:word_type] = "all_word"
      Word.all
    elsif params[:category_id].empty?
      Word.all.send "#{type}", current_user.id
    else
      category = @categories.find_by id: params[:category_id]
      words = category.words
      @words = words.send "#{type}", current_user.id
    end
    @words = @words.paginate(page: params[:page]).per_page Settings.page_size
  end

  private
  def type
    params[:word_type] == Settings["not_learn"] ? Settings["not_learn"] : params[:word_type]
  end
end

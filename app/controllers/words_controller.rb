class WordsController < ApplicationController
  before_action :logged_in_user, only: :index

  def index
    @categories = Category.all
    @words = if params[:category_id].nil?
      Word.all
    elsif params[:category_id].present? && params[:word_type].nil?
      Word.category params[:category_id]
    else
      Word.send "#{type}", current_user.id, params[:category_id]
    end
    @words = @words.paginate(page: params[:page]).per_page Settings.page_size
  end

  private
  def type
    params[:word_type] == Settings["not_learn"] ? Settings["not_learn"] : Settings["learned"]
  end
end

module ApplicationHelper
  def full_title page_title = ""
    base_title = t :title_base
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def sortable column, title = nil
    title ||= column.titleize 
    direction = column == params[:sort] && params[:direction] == "asc" ? "desc" : "asc"
    link_to title, {sort: column, direction: direction}
  end

  def answer_icon result
    true_answer?(result) ? "O" : "X"
  end
  
  def result_class result
    true_answer?(result) ? "true_answer" : ""
  end

  private
  def true_answer? result
    correct_answers = result.word.word_answers.select {|answer|
      answer.is_correct?}
    correct_answers.include? result.word_answer
  end
end

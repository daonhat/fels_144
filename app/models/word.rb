class Word < ActiveRecord::Base
  belongs_to :category
  
  has_many :word_answers, dependent: :destroy

  validates :content, presence: true, length: {maximum: 20}
  validate :check_answers

  accepts_nested_attributes_for :word_answers,
    reject_if: lambda {|a| a[:content].blank?}

  private
  def check_answers
    correct_answer = word_answers.select {|word_answer| word_answer.is_correct?}
    errors.add(:word_answers, I18n.t(:must_check)) if correct_answer.empty?
  end
end

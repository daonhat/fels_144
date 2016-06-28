class Word < ActiveRecord::Base
  belongs_to :category
  
  has_many :word_answers, dependent: :destroy
  has_many :results

  validates :content, presence: true, length: {maximum: 20}
  validate :check_answers

  accepts_nested_attributes_for :word_answers,
    reject_if: lambda {|a| a[:content].blank?}, allow_destroy: true

  scope :category, ->category_id{where category_id: category_id}
  scope :learned, ->(user_id, category_id){joins(results: :lesson)
    .where category_id: category_id, lessons: {user_id: user_id}}
  scope :not_learn, ->(user_id, category_id){where(category_id: category_id)
    .where.not id: learned(user_id, category_id)}

  private
  def check_answers
    correct_answer = word_answers.select {|word_answer| word_answer.is_correct?}
    errors.add(:word_answers, I18n.t(:must_check)) if correct_answer.empty?
  end
end

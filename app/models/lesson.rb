class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  has_many :results, dependent: :destroy
  has_many :words, through: :results

  before_create :render_words

  validate :check_number_of_word, on: :create

  accepts_nested_attributes_for :results

  private
  def list_words
    category.words.order("RANDOM()").limit Settings.number_word
  end

  def render_words
    self.words = list_words
  end

  def check_number_of_word
    @words = list_words
    if 0 == @words.size 
      errors.add(:lessons, I18n.t(:check_number_of_word))
    end
  end
end

class Category < ActiveRecord::Base
  has_many :lessons, dependent: :destroy
  has_many :words, dependent: :destroy

  validates :title, presence: true, length: {maximum: 50}
  validates :description, length: {maximum: 255}
end

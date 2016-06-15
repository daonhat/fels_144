class WordAnswer < ActiveRecord::Base
  belongs_to :word
  belongs_to :result
end

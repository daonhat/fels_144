class Activity < ActiveRecord::Base
  belongs_to :user
  
  enum action_type: ["login", "logout", "following", "learing"]
end

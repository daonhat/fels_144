class Activity < ActiveRecord::Base
  belongs_to :user
  
  scope :order_by_time, -> {order created_at: :desc}
  scope :feed, ->(following_ids, user_id){where "user_id IN (?) OR user_id = ?",
    following_ids, user_id}

  enum action_type: ["login", "logout", "following", "learned"]

  def content
    case action_type
    when "login"
      user.name + I18n.t("activity.login")
    when "logout"
      user.name + I18n.t("activity.logout")
    when "following"
      user.name + I18n.t("activity.following")
    when "learned"
      user.name + I18n.t("activity.learned")
    end
  end
  
  def target
    if following?
      User.find_by_id target_id
    elsif learned?
      Category.find_by_id target_id
    end
  end
end

class StaticPagesController < ApplicationController
  def home
    @feed_items = Activity.feed(current_user.following_ids, current_user.id).
      order_by_time.paginate page: params[:page] if logged_in?
  end

  def help
  end

  def about
  end

  def contact
  end
end

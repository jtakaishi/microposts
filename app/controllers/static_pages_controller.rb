class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build if logged_in?
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
      @feed_items = @feed_items.paginate(page: params[:page], :per_page => 10)
    end
  end
end
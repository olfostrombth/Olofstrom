class ApplicationController < ActionController::Base

  include PublicActivity::StoreController

  # Prevent CSRF attacks by raising an exception.d
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  #Helper method for getting current user
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :shuffle_hash
  def shuffle_hash
    Hash[self.to_a.sample(self.length)]
  end
  helper_method :shuffle_hash!
  def shuffle_hash!
    self.replace(self.shuffle)
  end

  def get_activities
    @activities = PublicActivity::Activity.order("created_at desc")
  end
end

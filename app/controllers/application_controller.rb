class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :sortable
  helper_method :sort_column, :sort_direction
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
end

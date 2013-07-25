class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  private
  def current_user
    @current_user ||= Gym.find(session[:gym_id]) if session[:gym_id]
	rescue ActiveRecord::RecordNotFound
	  session[:gym_id] = nil
	end
end

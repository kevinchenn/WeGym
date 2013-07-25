class SessionsController < ApplicationController
  # GET /sessions/new
	def new
	end

	# POST /sessions
	def create
	  gym = Gym.authenticate params[:email], params[:password]
	    if gym
	      session[:gym_id] = gym.id
	      redirect_to root_path, :notice => "Welcome back to WeGym"
	    else
	      redirect_to :login, :alert => "Invalid email or password"
	    end
	end

	def destroy
	  session[:gym_id] = nil
	  redirect_to root_path :notice => "You have been logged out"
	end


end

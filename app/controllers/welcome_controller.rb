class WelcomeController < ApplicationController
  def index
  	@gym = Gym.all
  end
end

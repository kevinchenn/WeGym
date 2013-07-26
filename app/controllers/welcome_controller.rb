class WelcomeController < ApplicationController
  def index
  	@gyms = Gym.all
  end
end

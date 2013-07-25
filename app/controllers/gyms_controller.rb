class GymsController < ApplicationController
  # GET /gyms
  def index
  end

  # GET /gyms/1
  def show
    @gym = Gym.find(params[:id])
    @is_admin = current_user && current_user.id == @gym.id
  end

  # GET /gyms/new
  def new
  if current_user
      redirect_to root_path, :notice => "You are already registered" 
    end
    @gym = Gym.new
  end

  # GET /gyms/1/edit
  def edit
    @gym = Gym.find(params[:id])
    if current_user.id != @gym.id
      redirect_to @gym
    end
  end

    # POST /gyms
  def create    
    @gym = Gym.new(params[:gym])

    if @gym.save
      session[:gym_id] = @gym.id
      redirect_to @gym, notice: 'Gym was successfully created.'      
    else
      render action: "new"
    end
  end

  # PUT /gyms/1/update
 def update
    @gym = Gym.find(params[:id])
    if @gym.update_attributes(params[:gym])
      redirect_to @gym, notice: 'Gym was successfully updated.'
    else
      render :action => 'edit'
    end
  end

  # GET /gyms/oauth/1
  def oauth
    if !params[:code]
      return redirect_to('/')
    end

    redirect_uri = url_for(:controller => 'gyms', :action => 'oauth', :gym_id => params[:gym_id], :host => request.host_with_port)
    @gym = Gym.find(params[:gym_id])
    begin
      @gym.request_wepay_access_token(params[:code], redirect_uri)
    rescue Exception => e
      error = e.message
    end

    if error
      redirect_to @gym, alert: error
    else
      redirect_to @gym, notice: 'We successfully connected you to WePay!'
    end
  end

end
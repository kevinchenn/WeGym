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

  # GET /gyms/create_plan/1
  def create_plan
    redirect_uri = url_for(:controller => 'gyms', :action => 'create_plan', :gym_id => params[:gym_id], :host => request.host_with_port)
    @gym = Gym.find(params[:gym_id])
    begin
      @gym.create_plan()
      redirect_to @gym
    rescue Exception => e
      error = e.message
      redirect_to @gym, alert: e.message
    end

  end

  def subscribe
    redirect_uri = url_for(:controller => 'gyms', :action => 'subscribe_success', :gym_id => params[:gym_id], :host => request.host_with_port_with_port)
    @gym = Gym.find(params[:gym_id])
    begin
      @subscription = @gym.create_subscription(redirect_uri)
    rescue Exception => e
      redirect_to @gym, alert: e.message
    end
  end

  # GET /gyms/subscribe_success/1
  def subscribe_success
    @gym = Gym.find(params[:gym_id])
    if (params['error'] && params['error_description'])
      return redirect_to @gym, alert: "Error - #{params['error_description']}"
    end
    redirect_to @gym, notice: "You are now subscribed! You should receive a confirmation email shortly."
  end


end

class SearchesController < ApplicationController
  before_action :visitor_analytics

  # GET /search/new
  def new
    @search = Search.new
  end

  # POST /search
  # POST /search.json
  def create
    params[:search][:ip] = @ip
    params[:search][:country] = @country
    params[:search][:state] = @state
    params[:search][:postal_code] = @postal_code
    params[:search][:city] = @city
    params[:search][:address] = @address
    params[:search][:coordinates] = @coordinates
    params[:search][:referer] = @referer
#    params[:search][:application] = @application
    params[:search][:browser_name] = @browser_name
    params[:search][:browser_version] = @browser_version
    params[:search][:is_bot] = @is_bot
    params[:search][:device_name] = @device_name
    params[:search][:platform_name] = @platform_name
    params[:search][:platform_version] = @platform_version
    params[:search][:is_mobile] = @is_mobile

    @search = Search.new(search_params)

    respond_to do |format|
      if @search.save
        format.html { redirect_to @search, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @search }
      else
        format.html { render :new }
        format.json { render json: @search, status: :unprocessable_entity }
      end
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @search = Search.find(params[:id])
  end


  private

  def visitor_analytics
    if Rails.env == "production"
      remote_ip = request.remote_ip
    else
      remote_ip = "179.197.211.89"
    end

    r = Geocoder.search(remote_ip).first
    @ip = r.ip
    @country = r.country
    @state = r.state
    @postal_code = r.postal_code
    @city = r.city
    @address = r.address.first
    @coordinates = r.coordinates.first.to_s + "," + r.coordinates.last.to_s
    @referer = request.referer

    user_agent = Browser.new(request.env["HTTP_USER_AGENT"])
    #@application = user_agent.application
    @browser_name = user_agent.name
    @browser_version = user_agent.version
    @is_bot = user_agent.bot?
    @device_name = user_agent.device.name
    @platform_name = user_agent.platform.name
    @platform_version = user_agent.platform.version
    @is_mobile = user_agent.device.mobile?
  end

  def search_params
    params.require(:search).permit(:instagram_path, :ip, :country, :state, :postal_code, :city, :address, :coordinates,
                                   :referer, :browser_name, :browser_version, :is_bot, :device_name, :platform_name,
                                   :platform_version, :is_mobile)
  end
end

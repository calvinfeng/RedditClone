class HubsController < ApplicationController
  before_action :ensure_logged_in

  def index
    @hubs = Hub.all
    render :index
  end

  def create
    @hub = Hub.new(hub_params)
    @hub.author_id = current_user.id

    if @hub.save
      redirect_to hub_url(@hub.id)
    else
      flash.now[:errors] = @hub.errors.full_messages
      render :new
    end
  end

  def update
    @hub = Hub.find_by_id(params[:id])
    if @hub.update(hub_params)
      redirect_to hub_url(@hub.id)
    else
      flash.now[:errors] = @hub.errors.full_messages
      render :edit
    end
  end

  def destroy
    @hub = Hub.find_by_id(params[:id])
    @hub.destroy
    redirect_to hubs_url
  end

  def new
    @hub = Hub.new
    render :new
  end

  def edit
    @hub = Hub.find_by_id(params[:id])
    render :edit
  end

  def show
    @hub = Hub.find_by_id(params[:id])
    render :show
  end

  private
  def hub_params
    params[:hub].permit(:title, :description)
  end

end

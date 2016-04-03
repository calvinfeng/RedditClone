class SessionsController < ApplicationController

  def create
    @user = User.find_by_credentials(params[:session][:email],
                                     params[:session][:password])
    if @user
      login!(@user)
      redirect_to hubs_url
    else
      @user = User.new(email: params[:session][:email])
      flash.now[:errors] = ["Incorrect email or password"]
      render :new
    end
  end

  def new
    @user = User.new
    render :new
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

end

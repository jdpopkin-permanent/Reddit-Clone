class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    username, password = params[:user][:username], params[:user][:password]
    @user = User.find_by_credentials(username, password)

    if @user
      set_current_user(@user)
      redirect_to subs_url
    else
      @user = User.new(params[:user])
      flash.now[:errors] ||= []
      flash.now[:errors] << "Authentication failed"
      render :new
    end
  end

  def destroy
    user = current_user
    user.session_token = nil
    session[:session_token] = nil
    redirect_to new_session_url
  end
end

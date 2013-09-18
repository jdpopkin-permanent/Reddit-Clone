class UsersController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    user = User.new(params[:user])

    if user.save
      set_current_user(user)
      redirect_to user_url(user)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += user.errors.full_messages
      @user = user
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def index
    fail
  end
end

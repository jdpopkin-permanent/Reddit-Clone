class SubsController < ApplicationController

  include SubsHelper

  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def new
    @url = subs_url
    @sub = Sub.new

    render :new
  end

  def create
    #begin
      @sub = Sub.new(params[:sub])
      @links = links_from_params(params)
      #fail

      @have_errors = false
      ActiveRecord::Base.transaction do
        # save here
        @sub.save

        @links.each do |link|
          # if this were done using a hidden field in the form, all links would
          # be nonnil
          link.user_id = current_user.id
          link.subs ||= []
          link.subs << @sub
          link.save
        end
        #raise SpecialError #unless @sub.valid? && @links.all? { |link| link.valid? }
        @sub.links ||= []
        @sub.links += @links
        @sub.save
        @have_errors = true unless @sub.valid? && @links.all? { |link| link.valid? }
      end


    #rescue SpecialError
    if @have_errors
      link_errors = @links.map do |link|
        link.errors.full_messages
      end

      link_errors = link_errors.flatten
      flash.now[:errors] ||= []
      flash.now[:errors] = @sub.errors.full_messages + link_errors
      #fail
      render :new
    else
      redirect_to sub_url(@sub)
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    redirect_to :show unless current_user == @sub.moderator
    @url = sub_url(@sub)

    render :edit
  end

  def update

  end
end

class SpecialError < StandardError

end

class LinksController < ApplicationController

  def show
    @link = Link.find(params[:id])
    @comment_hash = @link.comments_by_parent_id
    render :show
  end

  def edit
    @link = Link.find(params[:id])
    @url = link_url(@link)
    render :edit
  end

  def new
    @link = Link.new
    @url = links_url
    render :new
  end

  def update
    link = Link.find(params[:id])
    link.update_attributes(params[:link])
    redirect_to sub_url(link.subs.first) # eww, change this
  end

  def destroy
    link = Link.find(params[:id])
    link.destroy
    redirect_to :back
  end

  def create
    link = Link.new(params[:link])

    if link.save
      redirect_to sub_url(link.subs.first) # change me!
    else
      @link = link
      flash.now[:errors] ||= []
      flash.now[:errors] += link.errors.full_messages
      render :new
    end
  end
end

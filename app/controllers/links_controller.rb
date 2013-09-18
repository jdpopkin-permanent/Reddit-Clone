class LinksController < ApplicationController
  def edit

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
end

class CommentsController < ApplicationController

  def new
    @link_id = params[:link_id]
    @parent_comment_id = params[:parent_comment_id]
    render :new
  end

  def create
    comment = Comment.new(params[:comment])

    if comment.save
      redirect_to link_url(comment.link_id)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += comment.errors.full_messages
      render :new
    end
  end
end

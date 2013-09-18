class VotesController < ApplicationController

  def create
    @user_vote = UserVote.new(params[:user_vote])

    @link = Link.find(params[:link_id])
    @user_id = current_user.id

    if current_user.votes.include?(@link) || current_user.id != @user_vote.user_id
      redirect_to :back
    else
      # @link.votes ||= []
      # @link.votes += current_user

      if @user_vote.save
        redirect_to :back
      else
        # flash?
        # fail
        redirect_to :back
      end
    end
  end
end

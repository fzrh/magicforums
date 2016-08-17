class VotesController < ApplicationController
  respond_to :js
  before_action :authenticate!

  def upvote
    @vote = current_user.votes.find_or_create_by(comment_id: params[:comment_id])
    if @vote.update(value: 1)
      flash[:success] = "You've voted"
      VoteBroadcastJob.perform_now(@vote.comment)
    end
  end

  def downvote
    @vote = current_user.votes.find_or_create_by(comment_id: params[:comment_id])
    if @vote.update(value: -1)
      flash[:success] = "You've downvoted"
      VoteBroadcastJob.perform_now(@vote.comment)
    end
  end
end

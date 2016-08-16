class VotesController < ApplicationController

  before_action :find_or_create_vote
  before_action :authenticate!

  def upvote
    update_vote(1, 'voted')
  end

  def downvote
    update_vote(-1, 'downvoted')
  end

  private
    def find_or_create_vote
      @vote = current_user.votes.find_or_create_by(comment_id: params[:comment_id])
    end

    def update_vote(value, vote_type)
      if @vote && @vote.value != value
        @vote.update(value: value)
        flash[:alert] = "You've #{vote_type}"
      end
    end
end

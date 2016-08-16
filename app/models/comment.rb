class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  has_many :votes, dependent: :destroy

  def total_votes
    votes.pluck(:value).sum
  end
end

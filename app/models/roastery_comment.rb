class RoasteryComment < ApplicationRecord
  belongs_to :roastery
  belongs_to :user
  has_many :roastery_comment_votes, dependent: :destroy

  def votes_count
    roastery_comment_votes.where(vote: true).count
  end

  #after_create_commit -> { broadcast_append_to "roastery_#{roastery.id}_comments" }
end

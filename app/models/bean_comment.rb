class BeanComment < ApplicationRecord
  belongs_to :user
  belongs_to :bean
  has_many :bean_comment_votes, dependent: :destroy

  def likes_count
    bean_comment_votes.count
  end

end

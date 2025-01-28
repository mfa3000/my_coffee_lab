class BeanComment < ApplicationRecord
  belongs_to :user
  belongs_to :bean
  has_many :bean_comment_votes
end

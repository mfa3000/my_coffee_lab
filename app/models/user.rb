class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :roasteries
  has_many :beans
  has_many :roastery_comments
  has_many :bean_comments
  has_many :roastery_reviews
  has_many :bean_reviews
  has_many :favourite_roasteries
  has_many :favourite_beans
  has_many :roastery_comment_votes
  has_many :bean_comment_votes
  has_many :recipes

end

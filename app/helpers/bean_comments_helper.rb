module BeanCommentsHelper
  def user_voted?(bean_comment)
    current_user.voted?(bean_comment)
  end

  def vote_heart_icon(bean_comment)
    user_voted?(bean_comment) ? "❤️" : "🤍"
  end
end

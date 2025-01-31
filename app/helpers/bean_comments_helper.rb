module BeanCommentsHelper
  def user_liked?(bean_comment)
    current_user.liked?(bean_comment)
  end

  def like_heart_icon(bean_comment)
    user_liked?(bean_comment) ? "❤️" : "🤍"
  end
end

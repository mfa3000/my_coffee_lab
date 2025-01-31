class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:user_name])
  end

  helper_method :user_liked?

  def user_liked?(bean_comment)
    current_user.bean_comment_votes.exists?(bean_comment_id: bean_comment.id)
  end
end

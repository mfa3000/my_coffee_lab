class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :user_authorized_to_delete?


  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:user_name])
  end

  helper_method :user_voted?

  def user_voted?(bean_comment)
    current_user.bean_comment_votes.exists?(bean_comment_id: bean_comment.id)
  end

  def user_authorized_to_delete?(element)
    element.user == current_user || current_user.admin?
  end

end

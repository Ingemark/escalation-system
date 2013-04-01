class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    sign_out(current_user)
    redirect_to :back
  end
end

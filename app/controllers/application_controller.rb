class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_current_user

  private

  def set_current_user
    @current_user = User.find_by(id: session[:id])
  end

  def current_user
    @current_user
  end

  def authenticate_user!
    unless current_user
      redirect_to login_path
    end
  end
end

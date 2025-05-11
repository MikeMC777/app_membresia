class ApplicationController < ActionController::Base
  include Pundit
  before_action :authenticate_user!

  def authenticate_admin!
    redirect_to root_path, alert: 'No tienes permiso para acceder a esta página' unless current_user.admin?
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  private

  def user_not_authorized
    flash[:alert] = "No tienes permiso para realizar esta acción."
    redirect_to(request.referer || root_path)
  end
end

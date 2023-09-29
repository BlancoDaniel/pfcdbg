class ApplicationController < ActionController::Base
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


  private
  def user_not_authorized
    flash[:alert] = t("common.not_authorized")
    redirect_back(fallback_location: root_path)
  end
end

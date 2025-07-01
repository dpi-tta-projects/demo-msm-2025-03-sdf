module Punditable
  extend ActiveSupport::Concern
  include Pundit::Authorization

  included do
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back_or_to(root_path)
  end
end

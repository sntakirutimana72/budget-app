class ApplicationController < ActionController::Base
  before_action :load_directives
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def load_directives
    @app_title = ENV.fetch('BUDGET_APP_TITLE', 'BudgetApp')
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])
  end

  def authenticate_user!
    return super if user_signed_in? || devise_controller?

    redirect_to(get_started_path)
  end
end

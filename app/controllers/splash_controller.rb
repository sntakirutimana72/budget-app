class SplashController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @app_name = ENV.fetch('APP_NAME', 'Budget App')
  end
end

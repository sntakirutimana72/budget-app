class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: :splash

  def splash
    @app_name = ENV.fetch('APP_NAME', 'Budget App')
  end
end

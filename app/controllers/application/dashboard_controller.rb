module Application
  class DashboardController < ApplicationController
    before_action :authenticate_user!

    def index
      @thermostats = current_user.thermostats
    end
  end
end

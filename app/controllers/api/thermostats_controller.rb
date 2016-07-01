module API
  class ThermostatsController < APIController
    before_action :set_thermostat

    def show
      render nothing: true
    end


    private

    def set_thermostat
      @thermostat = Thermostat.find_by! uuid: params[:uuid]
    end
  end
end

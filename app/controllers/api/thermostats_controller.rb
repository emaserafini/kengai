module API
  class ThermostatsController < APIController
    before_action :set_thermostat

    def show
      render nothing: true
    end

    def update
      if @thermostat.update thermostat_params
        render nothing: true
      else
        render json: { errors: @thermostat.errors }, status: :unprocessable_entity
      end
    end


    private

    def set_thermostat
      @thermostat = Thermostat.find_by! uuid: params[:uuid]
    end

    def thermostat_params
      params.require(:thermostat).permit(:name, :enabled)
    end
  end
end

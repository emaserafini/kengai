module API
  class ThermostatsController < APIController
    before_action :set_thermostat

    def show
      render json: {}, status: :ok
    end

    def update
      if @thermostat.update thermostat_params
        render json: { thermostat: { temperature: { value: @thermostat.temperature.value } } }, status: :ok
      else
        render json: { errors: @thermostat.errors }, status: :unprocessable_entity
      end
    end


    private

    def set_thermostat
      @thermostat = Thermostat.find_by! uuid: params[:uuid]
    end

    def thermostat_params
      params.require(:thermostat).permit(:name, :enabled, temperature_attributes: [:value])
    end
  end
end

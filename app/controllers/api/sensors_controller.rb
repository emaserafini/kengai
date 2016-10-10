module API
  class SensorsController < APIController
    before_action :set_thermostat
    append_before_action :authenticate

    def update
      if @thermostat.update thermostat_params
        render :update
      else
        render json: { errors: @thermostat.errors }, status: :unprocessable_entity
      end
    end


    private

    def set_thermostat
      @thermostat = Thermostat.find_by! uuid: params[:thermostat_uuid]
    end

    def thermostat_params
      params.require(:thermostat).permit(
        temperature_attributes: [:value, :scale],
        humidity_attributes: [:value, :scale]
      )
    end
  end
end

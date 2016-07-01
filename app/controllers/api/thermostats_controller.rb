module API
  class ThermostatsController < APIController
    before_action :set_thermostat
    append_before_action :authenticate, only: :update

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

    def authenticate_token
      authenticate_with_http_token do |token, options|
        @thermostat.access_token == token
      end
    end

    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Token realm="Application"'
      render json: { errors: 'invalid token' }, status: :unauthorized
    end

    def authenticate
      authenticate_token || render_unauthorized
    end
  end
end

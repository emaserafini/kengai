module Application
  class ThermostatsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_thermostat, only: [:show, :edit, :update, :destroy]

    def index
      @thermostats = current_user.thermostats
    end

    def show
    end

    def new
      @thermostat = Thermostat.new
    end

    def edit
    end

    def create
      @thermostat = Thermostat.new(thermostat_params)
      @thermostat.subscribers.build user: current_user, admin: true

      if @thermostat.save
        redirect_to @thermostat, notice: 'Thermostat was successfully created.'
      else
        render :new
      end
    end

    def update
      if @thermostat.update(thermostat_params)
        redirect_to @thermostat, notice: 'Thermostat was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @thermostat.destroy
      redirect_to thermostats_url, notice: 'Thermostat was successfully destroyed.'
    end


    private

    def set_thermostat
      @thermostat = current_user.thermostats.find_by_uuid(params[:uuid])
    end

    def thermostat_params
      params.require(:thermostat).permit(:name)
    end
  end
end

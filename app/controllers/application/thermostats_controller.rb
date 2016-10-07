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
      @thermostat.enabled = false
      @thermostat.status = :unknown
      @thermostat.program_status = :manual
      @thermostat.offset_temperature = 2
      @thermostat.manual_program_target_temperature = 20
      @thermostat.minimum_run = 15
      @thermostat.subscribers.build user: current_user, admin: true
      @thermostat.build_temperature
      @thermostat.build_humidity

      if @thermostat.save
        redirect_to @thermostat, notice: 'Thermostat was successfully created.'
      else
        render :new
      end
    end

    def update
      respond_to do |format|
        if @thermostat.update(thermostat_params)
          format.html { redirect_to @thermostat, notice: 'Thermostat was successfully updated.' }
        else
          format.html { render :edit }
        end
        format.js
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
      params.require(:thermostat).permit(:name, :enabled)
    end
  end
end

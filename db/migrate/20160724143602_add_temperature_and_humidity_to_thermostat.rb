class AddTemperatureAndHumidityToThermostat < ActiveRecord::Migration[5.0]
  def change
    add_reference :thermostats, :temperature, null: false
    add_reference :thermostats, :humidity, null: false
  end
end

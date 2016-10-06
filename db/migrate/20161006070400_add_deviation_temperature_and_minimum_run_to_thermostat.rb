class AddDeviationTemperatureAndMinimumRunToThermostat < ActiveRecord::Migration[5.0]
  def change
    add_column :thermostats, :deviation_temperature, :float, null: false
    add_column :thermostats, :minimum_run, :integer, null: false
  end
end

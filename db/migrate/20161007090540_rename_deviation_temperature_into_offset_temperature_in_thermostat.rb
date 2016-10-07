class RenameDeviationTemperatureIntoOffsetTemperatureInThermostat < ActiveRecord::Migration[5.0]
  def change
    rename_column :thermostats, :deviation_temperature, :offset_temperature
  end
end

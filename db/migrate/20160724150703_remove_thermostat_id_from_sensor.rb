class RemoveThermostatIdFromSensor < ActiveRecord::Migration[5.0]
  def change
    remove_column :sensors, :thermostat_id, :string
  end
end

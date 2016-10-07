class AddManualProgramTargetTemperaureToThermostat < ActiveRecord::Migration[5.0]
  def change
    add_column :thermostats, :manual_program_target_temperature, :float, null: false
  end
end

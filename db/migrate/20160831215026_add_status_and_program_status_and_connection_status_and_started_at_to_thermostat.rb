class AddStatusAndProgramStatusAndConnectionStatusAndStartedAtToThermostat < ActiveRecord::Migration[5.0]
  def change
    add_column :thermostats, :status, :integer, null: false
    add_column :thermostats, :program_status, :integer, null: false
    add_column :thermostats, :started_at, :datetime
  end
end

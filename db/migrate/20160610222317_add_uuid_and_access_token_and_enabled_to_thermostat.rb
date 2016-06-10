class AddUuidAndAccessTokenAndEnabledToThermostat < ActiveRecord::Migration
  def change
    add_column :thermostats, :uuid, :uuid, null: false
    add_column :thermostats, :access_token, :uuid, null: false
    add_column :thermostats, :enabled, :boolean, null: false

    add_index :thermostats, :uuid, unique: true
    add_index :thermostats, :access_token, unique: true
  end
end

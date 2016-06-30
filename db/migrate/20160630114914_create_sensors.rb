class CreateSensors < ActiveRecord::Migration
  def change
    create_table :sensors do |t|
      t.references :thermostat, index: true, foreign_key: true, null: false
      t.string :type, null: false
      t.float :value
      t.string :scale
      t.datetime :value_updated_at
      t.timestamps null: false
    end

    add_index :sensors, [:thermostat_id, :type], unique: true
  end
end

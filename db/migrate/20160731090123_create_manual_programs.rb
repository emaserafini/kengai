class CreateManualPrograms < ActiveRecord::Migration[5.0]
  def change
    create_table :manual_programs do |t|
      t.references :thermostat, foreign_key: true, null: false
      t.integer :mode, null: false
      t.float :target_temperature, null: false
      t.float :deviation_temperature, null: false
      t.integer :minimum_run, null: false

      t.timestamps
    end
  end
end

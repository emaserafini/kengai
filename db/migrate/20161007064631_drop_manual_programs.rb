class DropManualPrograms < ActiveRecord::Migration[5.0]
  def change
    drop_table :manual_programs
  end
end

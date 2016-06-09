class CreateThermostats < ActiveRecord::Migration
  def change
    create_table :thermostats do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end

class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.references :thermostat, index: true, foreign_key: true, null: false
      t.boolean :admin, null: false

      t.timestamps null: false
    end
  end
end

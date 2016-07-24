class Sensor < ApplicationRecord
  before_save :update_value_updated_at, if: :value_changed?


  private

  def update_value_updated_at
    self.value_updated_at = Time.now
  end
end

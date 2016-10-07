module SafeUniqueness
  extend ActiveSupport::Concern

  included do
    around_save :save_managing_uniqueness,
      if: proc { |model| unique_fields(model).map{ |field| model.send("#{field}_changed?") }.include?(true) }
  end

  def save_managing_uniqueness
    attempts ||= 0
    self.class.connection.execute('SAVEPOINT before_record_create;')
    yield
    self.class.connection.execute('RELEASE SAVEPOINT before_record_create;')
  rescue ActiveRecord::RecordNotUnique => error
    attempts += 1
    if attempts < 3
      duplicated_field = error.message[/Key \((\w+)\)/, 1]
      send("assign_#{duplicated_field}", true) if duplicated_field && unique_fields(self).include?(duplicated_field)
      self.class.connection.execute('ROLLBACK TO SAVEPOINT before_record_create;')
      retry
    else
      raise error, 'Retries exhausted'
    end
  end


  private

  def unique_fields model
    model.class::UNIQUE_FIELDS
  end
end

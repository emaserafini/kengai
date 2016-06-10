require 'rails_helper'

RSpec.describe Thermostat, type: :model do
  describe 'validations' do
    it 'require name to be present' do
      thermostat = Thermostat.new
      expect(thermostat).to have(1).error_on :name
    end

    it 'pass when constraints are met' do
      subject.name = 'name'
      expect(subject).to be_valid
    end
  end
end

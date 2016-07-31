require 'rails_helper'

RSpec.describe ManualProgram, type: :model do
  describe 'validations' do
    it 'require thermostat to be present' do
      expect(subject).to have(1).error_on :thermostat
    end

    it 'require target_temperature to be numerically' do
      subject.target_temperature = 'foo'
      expect(subject).to have(1).error_on :target_temperature
    end

    it 'require deviation_temperature to be greater or equal to 0' do
      subject.deviation_temperature = -5
      expect(subject).to have(1).error_on :deviation_temperature
    end

    it 'require minimum_run to be greater or equal to 0 and integer' do
      subject.minimum_run = -4
      expect(subject).to have(1).error_on :minimum_run
      subject.minimum_run = 3.8
      expect(subject).to have(1).error_on :minimum_run
    end

    it 'pass when constraints are met' do
      subject.thermostat            = build :thermostat
      subject.mode                  = :heating
      subject.target_temperature    = 20.6
      subject.deviation_temperature = 0.2
      subject.minimum_run           = 20
      expect(subject).to be_valid
    end
  end

  describe 'on create' do
    subject { described_class.create(thermostat: build(:thermostat)).reload }

    it 'it is set with default values' do
      subject.mode                  = :heating
      subject.target_temperature    = 20
      subject.deviation_temperature = 0
      subject.minimum_run           = 0
    end
  end
end

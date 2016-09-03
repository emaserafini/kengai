require 'rails_helper'

RSpec.describe ThermostatStatusManager, type: :model do
  describe '#status' do
    it 'returns :standby when thermostat is not enebled' do
      subject = described_class.new build_stubbed(:thermostat)
      expect(subject.status).to eq :standby
    end

    it 'returns :unkown when temperature is not present' do
      subject = described_class.new build_stubbed(:thermostat, :enabled)
      expect(subject.status).to eq :unknown
    end

    it 'returns running status when status cannot be changed' do
      temperature = build :temperature, value: 10
      manual_program = build :manual_program, target_temperature: 20, minimum_run: 10
      subject = described_class.new build_stubbed(:manual_thermostat,
        temperature: temperature,
        manual_program: manual_program,
        status: :heating,
        started_at: 2.minutes.ago
      )
      expect(subject.status).to eq :heating
    end

    it 'returns running status when temperature is included in target temperature range' do
      temperature = build_stubbed :temperature, value: 20
      manual_program = build_stubbed :manual_program, target_temperature: 21, deviation_temperature: 3
      subject = described_class.new build_stubbed(:manual_thermostat,
        temperature: temperature,
        manual_program: manual_program,
        status: :heating,
        started_at: 2.minutes.ago
      )
      expect(subject.status).to eq :heating
    end

    it 'returns :heating when temperature is lower than target temperature' do
      temperature = build :temperature, value: 10
      manual_program = build :manual_program, target_temperature: 20
      subject = described_class.new build_stubbed(:manual_thermostat,
        temperature: temperature,
        manual_program: manual_program,
        status: :heating,
        started_at: 2.minutes.ago
      )
      expect(subject.status).to eq :heating
    end

    it 'returns :standby when temperature is higher than target temperature' do
      temperature = build :temperature, value: 22
      manual_program = build :manual_program, target_temperature: 20
      subject = described_class.new build_stubbed(:manual_thermostat,
        temperature: temperature,
        manual_program: manual_program,
        status: :heating,
        started_at: 2.minutes.ago
      )
      expect(subject.status).to eq :standby
    end
  end
end

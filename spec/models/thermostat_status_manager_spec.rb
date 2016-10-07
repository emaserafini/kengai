require 'rails_helper'

RSpec.describe ThermostatStatusManager, type: :model do
  describe '#status' do
    it 'returns :standby when thermostat is not enebled' do
      subject = described_class.new build_stubbed(:thermostat, :disabled)
      expect(subject.status).to eq :standby
    end

    it 'returns :unkown when temperature is not present' do
      subject = described_class.new build_stubbed(:thermostat)
      expect(subject.status).to eq :unknown
    end

    it 'returns :heating when the thermostat is running from a less time than minimum_run in minutes' do
      subject = described_class.new build_stubbed(:thermostat,
        temperature: build_stubbed(:temperature, value: 22),
        status: :heating,
        started_at: 2.minutes.ago
      )
      expect(subject.status).to eq :heating
    end

    it 'returns :heating when thermostat is running and temperature is included in target temperature range' do
      subject = described_class.new build_stubbed(:thermostat,
        temperature: build_stubbed(:temperature, value: 20),
        manual_program_target_temperature: 21,
        minimum_run: 0,
        offset_temperature: 3,
        status: :heating,
        started_at: 2.minutes.ago
      )
      expect(subject.status).to eq :heating
    end

    it 'returns :heating when temperature is lower than target temperature' do
      subject = described_class.new build_stubbed(:thermostat,
        temperature: build_stubbed(:temperature, value: 10),
        status: :heating,
        minimum_run: 0,
        offset_temperature: 0,
        started_at: 2.minutes.ago
      )
      expect(subject.status).to eq :heating
    end

    it 'returns :standby when temperature is higher than target temperature' do
      subject = described_class.new build_stubbed(:thermostat,
        temperature: build_stubbed(:temperature, value: 25),
        status: :heating,
        minimum_run: 0,
        offset_temperature: 0,
        started_at: 2.minutes.ago
      )
      expect(subject.status).to eq :standby
    end
  end
end

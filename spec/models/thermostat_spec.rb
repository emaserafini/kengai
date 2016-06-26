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

  describe 'on save' do
    context 'when uuid is already present' do
      let!(:other_thermostat) { create :thermostat }

      subject { described_class.new(name: 'new thermostat', uuid: other_thermostat.uuid) }

      it 'generate a new token and it saves successfully' do
        subject.save
        expect(subject.uuid).not_to eq other_thermostat.uuid
        expect(subject).to be_persisted
      end

      it 'does not modify access_token' do
        expected_access_token = subject.access_token = SecureRandom.uuid
        subject.save
        expect(subject.reload.access_token).to eq expected_access_token
      end
    end

    context 'when access_token is already present' do
      let!(:other_thermostat) { create :thermostat }

      subject { described_class.new(name: 'new thermostat', access_token: other_thermostat.access_token) }

      it 'generate a new token and it saves successfully' do
        subject.save
        expect(subject.access_token).not_to eq other_thermostat.access_token
        expect(subject).to be_persisted
      end

      it 'does not modify uuid' do
        expected_uuid = subject.uuid = SecureRandom.uuid
        subject.save
        expect(subject.reload.uuid).to eq expected_uuid
      end
    end
  end
end

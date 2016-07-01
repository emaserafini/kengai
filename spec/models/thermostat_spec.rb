require 'rails_helper'

RSpec.describe Thermostat, type: :model do
  describe 'validations' do
    it 'require name to be present' do
      expect(subject).to have(1).error_on :name
    end

    it 'require temperature to be present' do
      expect(subject).to have(1).error_on :temperature
    end

    it 'pass when constraints are met' do
      subject.name = 'name'
      subject.temperature = build :temperature
      expect(subject).to be_valid
    end
  end

  describe 'on save' do
    context 'when generated uuid is already present' do
      let!(:other_thermostat) { create :thermostat }

      subject { build(:thermostat, uuid: other_thermostat.uuid) }

      it 'generates a new token and it saves successfully' do
        subject.save
        expect(subject.uuid).not_to eq other_thermostat.uuid
        expect(subject).to be_persisted
      end

      it 'raises an error when uuid generation fails tree times' do
        allow(SecureRandom).to receive(:uuid).and_return other_thermostat.uuid
        expect { subject.save }.to raise_error ActiveRecord::RecordNotUnique, 'Retries exhausted'
      end

      it 'does not modify access_token' do
        expected_access_token = subject.access_token = SecureRandom.uuid
        subject.save
        expect(subject.reload.access_token).to eq expected_access_token
      end
    end

    context 'when generated access_token is already present' do
      let!(:other_thermostat) { create :thermostat }

      subject { build(:thermostat, access_token: other_thermostat.access_token) }

      it 'generates a new token and it saves successfully' do
        subject.save
        expect(subject.access_token).not_to eq other_thermostat.access_token
        expect(subject).to be_persisted
      end

      it 'raises an error when access_token generation fails tree times' do
        allow(SecureRandom).to receive(:uuid).and_return other_thermostat.access_token
        expect { subject.save }.to raise_error ActiveRecord::RecordNotUnique, 'Retries exhausted'
      end

      it 'does not modify uuid' do
        expected_uuid = subject.uuid = SecureRandom.uuid
        subject.save
        expect(subject.reload.uuid).to eq expected_uuid
      end
    end
  end
end

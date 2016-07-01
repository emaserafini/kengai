require 'rails_helper'

RSpec.describe 'Thermostat temperature API', type: :request do
  describe 'PUT /api/thermostats/:uuid' do
    let(:thermostat) { create :thermostat }

    it 'updates temperature successfully' do
      put "/api/thermostats/#{thermostat.uuid}", thermostat: { temperature_attributes: { value: 20.6 } }
      expect(json_response[:thermostat][:temperature][:value]).to eq 20.6
    end
  end
end

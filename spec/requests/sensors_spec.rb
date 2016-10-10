require 'rails_helper'

RSpec.describe 'Sensors API:', type: :request do
  describe 'PUT /api/thermostats/:uuid' do
    let(:thermostat) { create :thermostat }

    it 'render updates temperature and humidity succesfully when data is valid' do
      put "/api/thermostats/#{thermostat.uuid}/sensors",
        headers: { 'AUTHORIZATION' => ActionController::HttpAuthentication::Token.encode_credentials(thermostat.access_token) },
        params: { thermostat: { temperature_attributes: { value: 20.6, scale: 'C°' }, humidity_attributes: { value: 40 } } }

      expect(json_response[:thermostat][:temperature][:value]).to eq 20.6
      expect(json_response[:thermostat][:temperature][:scale]).to eq 'C°'
      expect(json_response[:thermostat][:humidity][:value]).to eq 40
      expect(json_response[:thermostat][:uuid]).to eq thermostat.uuid
    end
  end
end

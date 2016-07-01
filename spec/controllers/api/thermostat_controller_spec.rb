require 'rails_helper'

RSpec.describe API::ThermostatsController, type: :controller do
  let(:body) { JSON.parse response.body, symbolize_names: true }

  describe 'GET #show' do
    context 'when thermostat is not present' do
      before { get :show, { uuid: SecureRandom.uuid } }

      it { expect(response).to have_http_status(:not_found) }

      it 'returns an error message' do
        expect(body[:message]).to eq('record not found')
      end
    end

    context 'when thermostat is present' do
      before do
       thermostat = create(:thermostat)
        get :show, { uuid: thermostat.uuid }
      end

      it { expect(response).to have_http_status(:ok) }
    end
  end
end

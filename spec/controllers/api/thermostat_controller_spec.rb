require 'rails_helper'

RSpec.describe API::ThermostatsController, type: :controller do
  describe 'GET #show' do
    context 'when thermostat does not exists' do
      before { get :show, { uuid: SecureRandom.uuid } }

      it { expect(response).to have_http_status :not_found }
      it { expect(response.content_type).to eq 'application/json' }

      it 'returns an error message' do
        expect(json_response[:errors]).to eq 'record not found'
      end
    end

    context 'when thermostat exists' do
      before do
       thermostat = create(:thermostat)
        get :show, { uuid: thermostat.uuid }
      end

      it { expect(response).to have_http_status :ok }
      it { expect(response.content_type).to eq 'application/json' }
    end
  end

  describe 'PUT #update' do
    context 'when thermostat does not exists' do
      before { put :update, { uuid: SecureRandom.uuid } }

      it { expect(response).to have_http_status :not_found }
      it { expect(response.content_type).to eq 'application/json' }

      it 'returns an error message' do
        expect(json_response[:errors]).to eq 'record not found'
      end
    end

    context 'when thermostat exists' do
      context 'and access token is not valid' do
        before do
          thermostat = create(:thermostat)
          request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials 'invalid_token'
          put :update, { uuid: thermostat.uuid, thermostat: { name: 'foo' } }
        end

        it { expect(response).to have_http_status :unauthorized }
        it { expect(response.content_type).to eq 'application/json' }

        it 'returns an error message' do
          expect(json_response[:errors]).to eq 'invalid token'
        end
      end

      context 'and access token is valid' do
        before do
          thermostat = create(:thermostat)
          request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials thermostat.access_token
          put :update, { uuid: thermostat.uuid, thermostat: { name: name } }
        end

        context "and can't be updated" do
          let(:name) { '' }

          it 'returns an error message' do
            expect(json_response[:errors]).to eq({ name: ["can't be blank"] })
          end

          it { expect(response).to have_http_status :unprocessable_entity }
          it { expect(response.content_type).to eq 'application/json' }
        end

        context 'and can be updated' do
          let(:name) { 'foo' }

          it { expect(response).to have_http_status :ok }
          it { expect(response.content_type).to eq 'application/json' }
        end
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Application::ThermostatsController, type: :controller do
  sign_in

  let(:valid_attributes) { { name: 'valid name' } }

  let(:invalid_attributes) { { name: nil } }

  describe 'GET #index' do
    it 'assigns all thermostats as @thermostats' do
      thermostat = Thermostat.create! valid_attributes
      get :index
      expect(assigns(:thermostats)).to eq [thermostat]
    end
  end

  describe 'GET #show' do
    it 'assigns the requested thermostat as @thermostat' do
      thermostat = Thermostat.create! valid_attributes
      get :show, { id: thermostat.to_param }
      expect(assigns(:thermostat)).to eq thermostat
    end
  end

  describe 'GET #new' do
    it 'assigns a new thermostat as @thermostat' do
      get :new
      expect(assigns(:thermostat)).to be_a_new Thermostat
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested thermostat as @thermostat' do
      thermostat = Thermostat.create! valid_attributes
      get :edit, { id: thermostat.to_param}
      expect(assigns(:thermostat)).to eq thermostat
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it "creates a new Thermostat" do
        expect {
          post :create, { thermostat: valid_attributes}
        }.to change(Thermostat, :count).by(1)
      end

      it 'assigns a newly created thermostat as @thermostat' do
        post :create, { thermostat: valid_attributes}
        expect(assigns(:thermostat)).to be_a Thermostat
        expect(assigns(:thermostat)).to be_persisted
      end

      it 'redirects to the created thermostat' do
        post :create, { thermostat: valid_attributes }
        expect(response).to redirect_to Thermostat.last
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved thermostat as @thermostat' do
        post :create, { thermostat: invalid_attributes }
        expect(assigns(:thermostat)).to be_a_new Thermostat
      end

      it "re-renders the 'new' template" do
        post :create, { thermostat: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { name: 'Changed name' } }

      it 'updates the requested thermostat' do
        thermostat = Thermostat.create! valid_attributes
        put :update, { id: thermostat.to_param, thermostat: new_attributes }
        thermostat.reload
        expect(thermostat.name).to eq 'Changed name'
      end

      it 'assigns the requested thermostat as @thermostat' do
        thermostat = Thermostat.create! valid_attributes
        put :update, { id: thermostat.to_param, thermostat: valid_attributes}
        expect(assigns(:thermostat)).to eq(thermostat)
      end

      it 'redirects to the thermostat' do
        thermostat = Thermostat.create! valid_attributes
        put :update, { id: thermostat.to_param, thermostat: valid_attributes}
        expect(response).to redirect_to(thermostat)
      end
    end

    context 'with invalid params' do
      it 'assigns the thermostat as @thermostat' do
        thermostat = Thermostat.create! valid_attributes
        put :update, { id: thermostat.to_param, thermostat: invalid_attributes}
        expect(assigns(:thermostat)).to eq(thermostat)
      end

      it "re-renders the 'edit' template" do
        thermostat = Thermostat.create! valid_attributes
        put :update, { id: thermostat.to_param, thermostat: invalid_attributes}
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested thermostat' do
      thermostat = Thermostat.create! valid_attributes
      expect {
        delete :destroy, { id: thermostat.to_param }
      }.to change(Thermostat, :count).by(-1)
    end

    it 'redirects to the thermostats list' do
      thermostat = Thermostat.create! valid_attributes
      delete :destroy, { id: thermostat.to_param }
      expect(response).to redirect_to(thermostats_url)
    end
  end
end

require 'rails_helper'

RSpec.describe 'Dashboard page', :js do
  it 'logged user subscribed to a thermostat, sees current temperature with proper scale when sensor reading has send value in the last 5 minutes' do
    user = create :confirmed_user
    thermostat = create(:thermostat, user: user, temperature: build(:temperature,  value: 33.4, scale: '˚C'))
    sign_in user
    expect(page).to have_text '33.4'
    expect(page).to have_text '˚C'
  end

  it "logged user subscribed to a thermostat, sees 'NA' when sensor last reading is older than 5 minutes ago" do

  end
end

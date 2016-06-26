require 'rails_helper'

RSpec.describe 'Thermostat list', type: :feature do
  scenario 'logged users visits thermostat list page and sees only own thermostat' do
    user = create :confirmed_user
    create :thermostat, name: 'personal 1', user: user
    create :thermostat, name: 'personal 2', user: user
    create :thermostat, name: 'other'
    sign_in user
    visit thermostats_path

    expect(page).to have_text 'personal 1'
    expect(page).to have_text 'personal 2'
    expect(page).not_to have_text 'other'
  end
end

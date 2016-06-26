require 'rails_helper'

RSpec.describe 'Thermostat creation', type: :feature do
  let(:user) { create :confirmed_user }

  scenario 'logged user visits dashboard page, tries to add a new thermostat with valid data and sees a successfull message and see new thermostat in thermostats list page' do
    sign_in
    click_link 'Add thermostat'

    fill_in 'Name', with: 'My new thermostat'
    click_button 'Create Thermostat'
    expect(page).to have_text 'Thermostat was successfully created'

    visit thermostats_path
    expect(page).to have_text 'My new thermostat'
  end

  scenario 'logged user visits dashboard page, tries to add a new thermostat with valid data and sees an error message' do
    sign_in
    click_link 'Add thermostat'
    click_button 'Create Thermostat'

    expect(page).to have_text "Name can't be blank"
  end

  scenario 'visitor visits thermostat creation page being redirected to login form' do
    visit new_thermostat_path

    expect(page).to have_text 'Log in'
  end

  scenario 'user after creation sees thermostat disabled by default' do
    thermostat = create :thermostat, name: 'my', user: user
    sign_in user
    visit thermostat_path thermostat
    expect(page).to have_text 'disabled'
  end

  scenario 'user after creation sees thermostat API access token' do
    thermostat = create :thermostat, name: 'my', user: user
    sign_in user
    visit thermostat_path thermostat
    expect(page).to have_text thermostat.access_token
  end
end

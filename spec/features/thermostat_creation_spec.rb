require 'rails_helper'

RSpec.describe 'Thermostat creation', type: :feature do
  let!(:user) { User.create email: 'foo@example.com', password: 'password', password_confirmation: 'password', confirmed_at: Time.now }

  scenario 'Logged user visits dashboard page, tries to add a new thermostat with valid data and sees a successfull message' do
    sign_in user
    click_link 'Add thermostat'

    fill_in 'Name', with: 'Home'
    click_button 'Create Thermostat'

    expect(page).to have_text 'Thermostat was successfully created'
  end

  scenario 'Logged user visits dashboard page, tries to add a new thermostat with valid data and sees an error message' do
    sign_in user
    click_link 'Add thermostat'
    click_button 'Create Thermostat'

    expect(page).to have_text "Name can't be blank"
  end

  scenario 'Visitor visits thermostat creation page being redirected to login form' do
    visit new_thermostat_device_path

    expect(page).to have_text 'Log in'
  end
end

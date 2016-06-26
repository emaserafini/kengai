module DeviseFeatureMacros
  def sign_in(user = nil)
    user ||= create(:confirmed_user)
    visit new_user_session_path
    within 'form.new_user' do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
    end
  end
end

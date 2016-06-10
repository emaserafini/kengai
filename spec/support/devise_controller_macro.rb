module DeviseControllerMacros
  def sign_in user = nil
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in(user || create(:confirmed_user))
    end
  end
end
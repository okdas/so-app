module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in FactoryGirl.create(:admin)
    end
  end

  def login_user(user)
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      # user.confirm!
      sign_in user
    end
  end
end
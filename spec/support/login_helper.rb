module AuthMacros
  def log_in(attributes = {})
    visit login_path
    fill_in "email", with: current_user.email
    fill_in "password", with: current_user.password
    click_button "login"
  end

  def current_user
    @current_user || User.create(name: 'name',
                                 email: 'email@email.com',
                                 password: 'password',
                                 password_confirmation: 'password')
  end
end


require 'spec_helper'

feature "Login user" do
  before do
    User.create(name: 'u_name',
                email: 'email@email.com',
                password: 'password',
                password_confirmation: 'password')
    visit login_path
  end

  context 'when valid inputs' do
    subject { current_path }
    before do
      fill_in 'email', with: 'email@email.com'
      fill_in 'password', with: 'password'
      click_button 'login'
    end
    it { should eq root_path }
  end

  context 'when invalid inputs' do
    subject { page }
    before do
      fill_in 'email', with: 'email@email.com'
      fill_in 'password', with: 'wrong_password'
      click_button 'login'
    end
    it { should have_content "Email or password is invalid" }
  end
end

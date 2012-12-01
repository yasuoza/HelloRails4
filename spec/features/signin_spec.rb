require 'spec_helper'

feature "Visit signup_path" do
  subject { page }
  before { visit signup_path }

  it { should have_selector('input#user_name') }
  it { should have_selector('input#user_email') }
  it { should have_selector('input#user_password') }
  it { should have_selector('input#user_password_confirmation') }
  it { should have_selector('input[name=commit]') }
end

feature "Sign up User" do
  before { visit signup_path }

  context "Valid attributes" do
    subject { current_path }

    before do
      fill_in 'user_name', with: 'name'
      fill_in 'user_email', with: 'email@example.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_button 'Save'
    end

    it { should eq '/users/1' }
  end

  context "Invalid attributes" do
    subject { page }

    before do
      fill_in 'user_name', with: 'name'
      fill_in 'user_email', with: 'email@example.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'passwordpassword'
      click_button 'Save'
    end

    it { should have_content "Password confirmation doesn't match Password" }
  end
end

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

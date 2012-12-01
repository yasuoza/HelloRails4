require 'spec_helper'

feature 'Logout user' do
  before do
    log_in
  end

  scenario 'visit logout_path' do
    visit logout_path
    current_path.should eq '/'
  end
end

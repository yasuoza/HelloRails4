require "spec_helper"

describe UserMailer do
  let(:user) { User.create(name: 'u_name',
                            email: 'email@example.com',
                            password: 'pass',
                            password_confirmation: 'pass') }
  before do
    @email = UserMailer.welcome_email(user).deliver
  end

  it 'stacks queue' do
    UserMailer.queue.should_not be_empty
  end

  it 'sent to user' do
    @email.to.should eq [user.email]
  end

  it 'has welcome subject' do
    @email.subject.should match "Welcome to My Awesome Site"
  end

  it 'has welcome message' do
    @email.body.to_s.should match "Welcome to example.com, #{user.name}"
  end
end

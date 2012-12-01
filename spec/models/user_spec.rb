require 'spec_helper'

describe User do
  describe "#save" do
    context 'when valid attributes' do
      subject { User.new(name: 'u_name',
                         password: 'password',
                         password_confirmation: 'password') }

      it 'save without error' do
        lambda { subject.save }.should_not raise_error
      end

      it 'return true' do
        subject.save.should be_true
      end
    end

    context 'when invalid attritubes' do
      subject { User.new(name: 'u_name',
                         password: 'password',
                         password_confirmation: 'wrong_password') }

      it 'save without error' do
        lambda { subject.save }.should_not raise_error
      end

      it 'return false' do
        subject.save.should be_false
      end
    end
  end

  describe "#authenticate" do
    let(:user) { User.create(name: 'u_name',
                             password: 'password',
                             password_confirmation: 'password') }

    subject { user.authenticate(given_password) }

    context 'when valid password' do
      let(:given_password) { 'password' }
      it 'return true' do
        should be_true
      end
    end

    context 'when invalid password' do
      let(:given_password) { 'wrong_password' }
      it 'return false' do
        should be_false
      end
    end
  end
end

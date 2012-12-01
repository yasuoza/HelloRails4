require 'spec_helper'

describe Topic do
  it { should respond_to(:name) }
  it { should respond_to(:user_id) }
end

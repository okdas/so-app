require 'spec_helper'

describe Answer do
  it { should validate_presence_of :body }

  it { should have_many(:comments) }

  it { should belong_to(:user) }
  it { should belong_to(:question) }
end

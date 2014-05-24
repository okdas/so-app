require 'spec_helper'

describe Answer do
  it { should have_many(:comments) }
  it { should belong_to(:user) }
  it { should belong_to(:question) }
  it { should have_many(:attachments) }

  it { should accept_nested_attributes_for :attachments }

  it { should validate_presence_of :body }
end

require 'spec_helper'

describe User do

  it { should validate_presence_of :name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  it { should have_many :questions }

  it do
    should ensure_length_of(:name).
               is_at_least(2).
               is_at_most(20).
               with_short_message('Name must be more than 2 characters').
               with_long_message('Name cannot be more than 20 characters')
  end


end

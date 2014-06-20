require 'spec_helper'

describe Ability do
  subject(:ability) { Ability.new(user) }
  let(:user) { nil }

  it { should be_able_to :read, Question }
  it { should be_able_to :read, Answer }
  it { should be_able_to :read, Comment }

  it { should_not be_able_to :manage, :all }
end
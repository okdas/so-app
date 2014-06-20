require 'spec_helper'

describe Ability do
  subject(:ability) { Ability.new(user) }
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }

  it { should be_able_to :read, :all }

  it { should be_able_to :create, Question }
  it { should be_able_to :create, Answer }
  it { should be_able_to :create, Comment }

  it { should_not be_able_to :manage, :all }

  it { should be_able_to :update, create(:question, user: user), user_id: user.id }
  it { should_not be_able_to :update, create(:question, user: another_user), user_id: user.id }

  it { should be_able_to :update, create(:answer, user: user), user_id: user.id }
  it { should_not be_able_to :update, create(:answer, user: another_user), user_id: user.id }
end
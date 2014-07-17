class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      user.admin? ? admin_abilities : user_abilities(user)
    else
      guest_abilities
    end
  end

  def user_abilities(user)
    guest_abilities
    can :create, [Question, Answer, Comment]
    can :update, [Question, Answer], user_id: user.id
    # can :up, Vote
    # can :down, Vote
    # cannot :up, Vote, user_id: user.id
    # cannot :down, Vote, user_id: user.id
  end

  def guest_abilities
    can :tagged, Question
    can :read, :all
  end

  def admin_abilities
    can :manage, :all
  end
end
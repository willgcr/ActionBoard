class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest
    return if !user.persisted?

    can [:read, :update, :destroy], User, id: user.id

    can :manage, List, owner_user_id: user.id
    can :read, List, list_shares: { user_id: user.id }

    can :new, Task
    can [:create, :read, :update, :destroy], Task, list: { list_shares: { user_id: user.id } }
    can :manage, Task, list: { owner_user_id: user.id }
  end
end

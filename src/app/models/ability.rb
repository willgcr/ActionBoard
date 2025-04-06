class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest
    return if !user.persisted?
    can [:read, :update, :destroy], User, id: user.id
  end
end

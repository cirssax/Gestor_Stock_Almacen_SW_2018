class Ability
  include CanCan::Ability

  def initialize(user)
    user || AdminUser.new
    if user.id_rol == 1
      can [:create, :read, :edit, :update], Product
      can [:create, :read, :edit, :update], Type
      can [:create, :read, :edit, :update], User
      can [:create, :read], Sale
    elsif user.id_rol == 2
      can :read, Product
      can :read, Type
      can [:read, :create], Sale

      cannot [:create, :edit, :update], Product
      cannot [:create, :edit, :update], Type
      cannot [:create, :read, :edit, :update], User
    else
      cannot [:create, :read, :edit, :update], Product
      cannot [:create, :read, :edit, :update], Type
      cannot [:create, :read, :edit, :update], User
      cannot [:create, :read], Sale
    end
  end
end

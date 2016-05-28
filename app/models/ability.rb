class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:

    user ||= User.new # guest user (not logged in)
    #user=current_user
    
    if user.admin?
      can :manage, :all
    else
      can :read,   :all
      can :manage, User,        id:       user.id
      # can :manage, :api
      # cannot :users, :api
      # can :manage, Building,    creator_id:  user.id
      # can :manage, Building,    manager_id:  user.id
      # can :manage, Building,    district: { manager_id: user.id } #se puede editaar un edificio si el usuario es administrador del edificio
      # can :create, Question
      # can :manage, Question,    user_id:     user.id #se pueden editar y eliminar tus preguntas
      # can :manage, Answer,      user_id:     user.id #se pueden editar y eliminar tus respuestas
      # #se pueden contestar respuestas solo si la pregunta fue echa por ti
      # can :create, Answer,      question: { user_id: user.id }

      # can :manage, BuildingImage, building: { manager_id: user.id }
      # can :manage, BuildingImage, building: { creator_id: user.id }

      # can :manage, OtherAttribute, building: { manager_id: user.id }
      # can :manage, OtherAttribute, building: { creator_id: user.id }
    end

    can :create, Building

    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end

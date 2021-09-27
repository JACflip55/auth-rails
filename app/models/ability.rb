# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
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

    self.merge Abilities::Admin.new(user) if user.admin? and user.role == 'superadmin'

    self.merge Abilities::Supervisor.new(user) if user.supervisor? and user.role == 'auditor'
    
    self.merge Abilities::Collaborator.new(user) if user.collaborator? and user.role == 'collaborator'

    self.merge Abilities::Superadmin.new(user) if user.role == 'superadmin'

    self.merge Abilities::Auditor.new(user) if user.role == 'auditor'

    self.merge Abilities::Manager.new(user) if user.role == 'manager'

    self.merge Abilities::Registred.new(user) if user.role == 'registred'
    
  end
end
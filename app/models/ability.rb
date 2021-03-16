# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)      
    alias_action :read, :create, :update, to: :cru    
     
    if user.is_a?(User)
      case 
      when user.user?
        can :cru, Order
        can :read, Book
      when user.manager?
        can :manage, [Author, Book, Category]        
        can :read, User, id: user.id
        can :cru, Order
      end
    elsif user.is_a?(AdminUser)
      case 
      when user.admin?
        can :manage, :all
        cannot :destroy, AdminUser
      when user.main_admin?
        can :manage, :all
      end
    else
      can :read, Book
    end 
  end
end

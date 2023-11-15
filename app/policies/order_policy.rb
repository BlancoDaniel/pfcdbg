class OrderPolicy < ApplicationPolicy
    attr_reader :user, :order
  
    def initialize(user, order)
      @user = user
      @order = order
    end

    def show?
      user&.has_role?(:client) && user&.client&.id == order&.client_id
    end 
    
end
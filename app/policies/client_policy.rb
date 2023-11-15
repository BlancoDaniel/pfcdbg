class ClientPolicy < ApplicationPolicy
    attr_reader :user, :client
  
    def initialize(user, client)
      @user = user
      @client = client
    end
  
    def show?
      user&.has_role?(:client) && user&.client&.id == client.id
    end
    
end
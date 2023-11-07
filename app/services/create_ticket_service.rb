class CreateTicketService

    def initialize(event, order, current_client)
        @event = event
        @order = order
        @current_client = current_client
    end

    def create_ticket
        code = generate_random_code(5) # Call a method to generate the code
    
        ticket_params = {
          code: code,
          order_id: @order.id,
          client_id: @current_client.id,
          event_id: @event.id
        }
    
        Ticket.create(ticket_params)
    end
    
    private

    def generate_random_code(length)
        charset = ('A'..'Z').to_a
        code = Array.new(length) { charset.sample }.join
        code += @current_client.id.to_s 
    end
      
end
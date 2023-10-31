class CreateOrderService

    def initialize(session_id, event, current_client)
        @session_id = session_id
        @event = event
        @current_client = current_client
    end

    def create_order
        unit_amount = @event.price
        checkout_session = Stripe::Checkout::Session.retrieve(@session_id)
        total = BigDecimal(checkout_session.amount_total) / BigDecimal('100')
        quantity = total / unit_amount
    
        order_params = {
          unit_amount: unit_amount,
          total: total,
          quantity: quantity,
          order_date: Time.now,
          status: 'payed',
          session_id: @session_id,
          client_id: @current_client.id,
          event_id: @event.id
        }
    
        Order.create(order_params)
    end

end
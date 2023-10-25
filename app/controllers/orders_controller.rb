class OrdersController < ApplicationController

    def show
        order
        @event = Event.find(order.event_id)
    end

    def new
        @checkout_session = Stripe::Checkout::Session.retrieve(params[:session_id])
        existing_order = Order.find_by(session_id: params[:session_id])

        return redirect_to order_path(existing_order.id) if existing_order

        unit_amount = event.price
        total = BigDecimal(@checkout_session.amount_total) / BigDecimal('100')
        quantity = total / unit_amount
      
        @order = Order.new(
            unit_amount: unit_amount,
            total: total,
            quantity: quantity,
            order_date: Time.now,  
            status: 'payed',
            session_id: order_params[:session_id]
        )
    

        @order.client_id = current_client.id
        @order.event_id = event.id
    
        puts "Order attributes: #{@order.inspect}" 
        if @order.save

        else

        end
      
    end
      

    private

    def order_params
        params.permit(:event_id, :session_id)
    end
      

    def event
        @event = Event.find(params[:event_id])
    end

    def current_client
        if current_user # Verifica si el usuario está autenticado
          @current_client ||= Client.find_by(user_id: current_user.id)
        end
    end

    def order
        @order = Order.find(params[:id])
    end
end

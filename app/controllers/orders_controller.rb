class OrdersController < ApplicationController

    def show
        order
        authorize @order
        @event = Event.find(order.event_id)
        @tickets = tickets

        respond_to do |format|
            format.html
            format.pdf do
              render pdf: "#{order.id}_#{@event.id}", template: "orders/show", encoding: 'UTF-8'
            end
        end
    end

    def new
        existing_order = Order.find_by(session_id: params[:session_id])
        return redirect_to order_path(existing_order.id) if existing_order

        create_order_service = CreateOrderService.new(params[:session_id], event, current_client)
        @order = create_order_service.create_order

        create_ticket_service = CreateTicketService.new(event, @order, current_client)

        @order.quantity.times do
            @ticket = create_ticket_service.create_ticket
            qr_ticket_service = QrTicketService.new(@ticket)
            qr_ticket_service.generate_qr
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
        if current_user
          @current_client ||= Client.find_by(user_id: current_user.id)
        end
    end

    def order
        @order = Order.find(params[:id])
    end

    def tickets
        @tickets = Ticket.where(order_id: params[:id]).to_a
    end
      
end

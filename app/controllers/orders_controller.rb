class OrdersController < ApplicationController

    def show
        order
        @event = Event.find(order.event_id)
    end

    def new
        existing_order = Order.find_by(session_id: params[:session_id])
        return redirect_to order_path(existing_order.id) if existing_order

        create_order_service = CreateOrderService.new(params[:session_id], event, current_client)
        @order = create_order_service.create_order
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

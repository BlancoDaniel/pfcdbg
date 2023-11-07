class TicketPurchaseService
    def initialize(user, event, input_quantity, session)
      @user = user
      @event = event
      @input_quantity = input_quantity
      @session = session
    end
  
    def purchase_ticket
          
        cache_key = "event_#{@event.id}_user_#{@user.id}"
        cached_data = Rails.cache.read(cache_key)
    
        if cached_data
            return { success: true, data: cached_data }
        else
            return { success: false, message: "No hay tantas entradas disponibles" } if @input_quantity > @event.ticket_quantity
            return { success: false, message: "Solo se permite la compra de 6 entradas" } if @input_quantity > 6
    
            @event.update(ticket_quantity: @event.ticket_quantity - @input_quantity)
            @user.set_payment_processor :stripe
            @user.payment_processor.customer
    
            total = @input_quantity * @event.price
    
            checkout_session = @user.payment_processor.checkout(
            mode: 'payment',
            line_items: [{
                price_data: {
                currency: 'eur',
                unit_amount: (@event.price * 100).to_i,
                product_data: {
                    name: @event.name,
                },
                },
                quantity: @input_quantity
            }],
            success_url: "http://127.0.0.1:3000/orders/new?event_id=#{@event.id}",
            cancel_url: 'http://127.0.0.1:3000/events'
            )
            @session[:checkout_session_id] = checkout_session.id
            checkout_session_id = @session[:checkout_session_id]
    
            DestroyCheckoutSessionJob.set(wait: 1.minutes).perform_later(@event, @input_quantity, checkout_session_id)
    
            cached_data = { event: @event, total: total, checkout_session: checkout_session, input_quantity: @input_quantity }
            Rails.cache.write(cache_key, cached_data, expires_in: 1.minutes)
    
            return { success: true, data: cached_data }
        end
    end

  def destroy_checkout_session
    checkout_session_id = @session[:checkout_session_id]
    event = @event

    DestroyCheckoutSessionJob.perform_now(event, @input_quantity, checkout_session_id)

    cache_key = "event_#{event.id}_user_#{@user.id}"
    Rails.cache.delete(cache_key)
  end
    
  end
  
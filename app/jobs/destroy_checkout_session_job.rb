class DestroyCheckoutSessionJob < ApplicationJob
  queue_as :default

  def perform(event, input_quantity, checkout_session_id)
  checkout_session = Stripe::Checkout::Session.retrieve(checkout_session_id)

  if checkout_session.status != 'expired' ||checkout_session.status != 'complete'
      event.update(ticket_quantity: event.ticket_quantity + input_quantity.to_i)
      Stripe::Checkout::Session.expire(checkout_session_id)
    end
  end

end

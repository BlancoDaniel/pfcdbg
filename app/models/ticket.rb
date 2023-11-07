class Ticket < ApplicationRecord
  belongs_to :event
  belongs_to :order
  belongs_to :client

  validates :code,
            :event_id,
            :order_id,
            :client_id,
            presence: true
end

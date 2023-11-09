class Ticket < ApplicationRecord
  has_one_attached :qrcode

  belongs_to :event
  belongs_to :order
  belongs_to :client

  validates :code,
            :event_id,
            :order_id,
            :client_id,
            presence: true
end

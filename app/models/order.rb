class Order < ApplicationRecord
  belongs_to :client
  belongs_to :event

  validates :quantity,
            :unit_amount,
            :total,
            :order_date,
            :status,
            presence: true

end

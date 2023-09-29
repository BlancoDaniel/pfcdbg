class Event < ApplicationRecord

  validates :name,
            :location,
            :description,
            :date,
            :ticket_quantity,
            :price,
            presence: true

  belongs_to :category, :promoter
end

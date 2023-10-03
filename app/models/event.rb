class Event < ApplicationRecord
  has_one_attached :poster

  validates :name,
            :location,
            :description,
            :date,
            :ticket_quantity,
            :price,
            presence: true

  belongs_to :category
  belongs_to :promoter, class_name: 'Promoter'


end

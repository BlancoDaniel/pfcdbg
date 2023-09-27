class Client < ApplicationRecord
  belongs_to :user
  validates :name,
            :surname,
            :address,
            :nif,
            :phone_number,
            presence: true


end

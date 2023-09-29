class Client < ApplicationRecord
  belongs_to :user
  validates :name,
            :surname,
            :address,
            :phone_number,
            presence: true

  validates :nif, presence: true, format: { with: /\A[XYZ\d]\d{7}[A-Z]\z/, message: "El formato del NIF no es válido" }

end

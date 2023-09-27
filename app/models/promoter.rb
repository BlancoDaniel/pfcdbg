class Promoter < ApplicationRecord
  belongs_to :user

  validates :name,
            :address,
            :cif,
            :phone_number,
            presence: true

end

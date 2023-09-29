class Promoter < ApplicationRecord
  belongs_to :user
  has_many :events, dependent: :restrict_with_exception

  validates :name,
            :address,
            :cif,
            :phone_number,
            presence: true

end

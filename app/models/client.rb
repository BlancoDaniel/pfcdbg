class Client < ApplicationRecord
  validates :name, presence: true
  validates :surname, presence: true
  validates :address, presence: true
  validates :nif, presence: true
  validates :phone_number, presence: true

  belongs_to :user
end

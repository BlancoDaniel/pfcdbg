class Promoter < ApplicationRecord
  validates :name, presence: true
  validates :address, presence: true
  validates :cif, presence: true
  validates :phone_number, presence: true

  belongs_to :user
end

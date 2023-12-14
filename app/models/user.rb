class User < ApplicationRecord
  rolify
  has_one :client
  has_one :promoter

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  pay_customer stripe_attributes: :stripe_attributes

  def stripe_attributes(pay_customer)
    {
    }
  end
end
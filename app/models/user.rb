class User < ApplicationRecord
  rolify
  has_one :client
  has_one :promoter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  pay_customer stripe_attributes: :stripe_attributes

  def stripe_attributes(pay_customer)
    {
      address:{
        city: pay_customer.owner.city,
        country: pay_customer.owner.country
      },
      metadata:{
        pay_customer_id: pay_customer.id,
        user_id: id
      }
    }
  end
end
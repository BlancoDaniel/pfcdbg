class AddUserToPromoters < ActiveRecord::Migration[7.0]
  def change
    add_reference :promoters, :user, null: false, foreign_key: true
  end
end

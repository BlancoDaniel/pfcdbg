class AddPromoterToEvents < ActiveRecord::Migration[7.0]
  def change
    add_reference :events, :promoter, null: false, foreign_key: true
  end
end

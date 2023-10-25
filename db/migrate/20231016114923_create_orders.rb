class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :quantity, null: false
      t.decimal :unit_amount, null: false
      t.decimal :total, null: false
      t.datetime :order_date, null: false
      t.string :status, null: false

      t.timestamps
    end
    add_reference :orders, :category, null: false, foreign_key: true
    add_reference :orders, :client, null: false, foreign_key: true
  end
end

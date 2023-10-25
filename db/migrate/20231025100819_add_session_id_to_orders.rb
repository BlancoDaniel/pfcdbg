class AddSessionIdToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :session_id, :string
  end
end

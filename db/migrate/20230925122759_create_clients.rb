class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :name, null: false
      t.string :surname, null: false
      t.string :address, null: false
      t.string :nif, null: false
      t.string :phone_number, null: false

      t.timestamps
    end
  end
end

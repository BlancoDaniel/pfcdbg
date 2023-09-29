class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name, null:false
      t.string :location, null:false
      t.text :description, null:false
      t.datetime :date, null:false
      t.integer :ticket_quantity, null:false
      t.decimal :price, null:false

      t.timestamps
    end
  end
end

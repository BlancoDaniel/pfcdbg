class CreatePromoters < ActiveRecord::Migration[7.0]
  def change
    create_table :promoters do |t|
      t.string :name , null: false
      t.string :address, null: false
      t.string :cif, null: false
      t.string :phone_number, null: false

      t.timestamps


    end

  end
end

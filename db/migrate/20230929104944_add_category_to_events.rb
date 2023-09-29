class AddCategoryToEvents < ActiveRecord::Migration[7.0]
  def change
    add_reference :events, :category, null: false, foreign_key: true
  end
end

class CreateIngredients < ActiveRecord::Migration[6.1]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.integer :quantity
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end

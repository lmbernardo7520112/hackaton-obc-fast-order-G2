class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.references :category, null: false, foreign_key: true
      t.decimal :price, precision: 10, scale: 2
      t.string :time
      t.integer :status

      t.timestamps
    end
  end
end

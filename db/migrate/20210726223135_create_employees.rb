class CreateEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :employees do |t|
      t.string :name
      t.integer :type_function
      t.integer :status

      t.timestamps
    end
  end
end

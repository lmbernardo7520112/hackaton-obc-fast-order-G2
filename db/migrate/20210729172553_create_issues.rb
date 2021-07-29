class CreateIssues < ActiveRecord::Migration[6.1]
  def change
    create_table :issues do |t|
      t.references :project, null: false, foreign_key: true
      t.integer :order_number
      t.string :title
      t.string :description
      t.datetime :created_on
      t.datetime :last_updated_on
      t.string :last_updater
      t.string :tester
      t.string :fixer
      t.string :creator
      t.string :priority
      t.string :status
      t.date :due_date

      t.timestamps
    end
  end
end

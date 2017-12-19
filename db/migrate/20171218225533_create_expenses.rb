class CreateExpenses < ActiveRecord::Migration[5.1]
  def change
    create_table :expenses do |t|
      t.string :reason
      t.decimal :amount
      t.string :expense_id

      t.timestamps
    end
  end
end

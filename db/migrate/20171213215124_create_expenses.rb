class CreateExpenses < ActiveRecord::Migration[5.1]
  def change
    create_table :expenses do |t|
      t.string :reason
      t.decimal :amount
      t.integer :expense_Id

      t.timestamps
    end
  end
end

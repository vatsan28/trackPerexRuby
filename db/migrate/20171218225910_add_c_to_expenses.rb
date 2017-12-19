class AddCToExpenses < ActiveRecord::Migration[5.1]
  def change
    add_reference :expenses, :users, foreign_key: true
  end
end

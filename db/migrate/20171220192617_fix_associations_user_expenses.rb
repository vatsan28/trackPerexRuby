class FixAssociationsUserExpenses < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :user_id, :string
    remove_column :expenses, :expense_id, :string
    remove_column :expenses, :users_id, :bigint
    add_reference :expenses, :user, foreign_key: true
  end
end

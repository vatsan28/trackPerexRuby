class ChangePhoneNumberToBeStringInCustomers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :phoneNumber, :string
  end
end

class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :user_id
      t.string :firstName
      t.string :lastName
      t.integer :phoneNumber
      t.string :email

      t.timestamps
    end
  end
end

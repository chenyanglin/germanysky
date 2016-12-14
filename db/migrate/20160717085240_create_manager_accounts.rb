class CreateManagerAccounts < ActiveRecord::Migration
  def change
    create_table :manager_accounts do |t|
      t.string :name
      t.string :password_digest
      t.string :email
      t.string :phone
      t.string :role

      t.timestamps null: false
    end
  end
end

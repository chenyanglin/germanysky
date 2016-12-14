class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :account_name
      t.string :password_digest
      t.string :name
      t.string :sex
      t.string :birthday
      t.string :email
      t.string :email_backup
      t.string :phone1
      t.string :phone2
      t.string :address
      t.integer :role, :default => 2
      t.string :account_level_id
      t.integer :score, :default => 0
      t.integer :point
      t.string :deleted
      
      t.timestamps null: false
    end
  end
end

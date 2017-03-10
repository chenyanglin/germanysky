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
      t.integer :point, :default => 0
      t.string :deleted
      
      t.timestamps null: false
    end
  end
end
# Account.create!( :account_name => "germanysky", :password_digest => "germanytest" ,:name => "種馬",:sex=>"男",:email => "germanyskt@gmail.com",:role =>1 , :account_level_id => "1",:score => 0,:point =>100000)
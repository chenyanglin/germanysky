class CreateNewsletterEmails < ActiveRecord::Migration
  def change
    create_table :newsletter_emails do |t|
      t.string :email , :unique => true
      t.string :account_id
      t.string :account_name
      t.string :name
      t.integer :status
      t.timestamps null: false
    end
  end
end

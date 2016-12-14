class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :account_id
      t.string :account_name
      t.string :title
      t.string :content
      t.integer :status, :default => 0
      t.timestamps null: false
    end
     create_table :replies do |t|
      t.string :message_id
      t.string :account_id
      t.string :account_name
      t.string :content
      t.timestamps null: false
    end
  end
end

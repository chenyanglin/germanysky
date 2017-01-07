class CreateNewsletters < ActiveRecord::Migration
  def change
    create_table :newsletters do |t|
      t.string :subject
      t.string :content
      t.string :status #0:未發送 1:已發送
      t.timestamps null: false
    end
  end
end

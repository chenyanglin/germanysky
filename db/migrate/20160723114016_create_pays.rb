class CreatePays < ActiveRecord::Migration
  def change
    create_table :pays do |t|
      t.string :name
      t.string :description
      t.boolean :available

      t.timestamps null: false
    end
  end
end

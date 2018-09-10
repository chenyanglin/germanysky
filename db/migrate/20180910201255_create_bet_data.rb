class CreateBetData < ActiveRecord::Migration
  def change
    create_table :bet_data do |t|
      t.string :name
      t.string :game
      t.string :play
      t.string :goal
      t.string :team
      t.string :money
      t.string :status
      t.string :challenger
      t.timestamps null: false
    end
  end
end

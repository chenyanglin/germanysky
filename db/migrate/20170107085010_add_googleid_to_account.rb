class AddGoogleidToAccount < ActiveRecord::Migration
  def change
  	add_column :accounts, :googleid, :string
  end
end

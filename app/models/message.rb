class Message < ActiveRecord::Base
	has_many :replies, :dependent => :destroy
	belongs_to :account, foreign_key: "account_id"
end

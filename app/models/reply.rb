class Reply < ActiveRecord::Base
	belongs_to :message
	belongs_to :account, foreign_key: "account_id"
end

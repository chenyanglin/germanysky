class OrderMessage < ActiveRecord::Base
belongs_to :order, foreign_key: "order_id"
belongs_to :account, foreign_key: "account_id"
end

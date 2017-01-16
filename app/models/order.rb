class Order < ActiveRecord::Base
	has_many :order_products, :dependent => :destroy
	belongs_to :account, foreign_key: "account_id"
	has_many :order_messages, :dependent => :destroy

	#pay_status 
	#1:未付款
	#2:已付款未確認
	#3:已確認付款
	#4:逾期未付款
	#5:貨到付款
	#6:完成
	#delivery_status
	#1:未出貨
	#2:已出貨
	#3:已確認取貨
	#4:完成
end

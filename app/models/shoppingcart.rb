class Shoppingcart < ActiveRecord::Base
	belongs_to :account, foreign_key: "account_id"
	belongs_to :product, foreign_key: "product_id"
end
class Salecart < ActiveRecord::Base
	belongs_to :account, foreign_key: "account_id"
	belongs_to :specialoffer, foreign_key: "specialoffer_id"
	has_many :salecart_products
end

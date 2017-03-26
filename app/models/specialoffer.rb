class Specialoffer < ActiveRecord::Base
	has_many :product_specialofferships, :dependent => :destroy
  	has_many :products, :through => :product_specialofferships
  	has_many :product_options, :through => :product_specialofferships
  	has_one :offer_image
end

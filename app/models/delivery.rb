class Delivery < ActiveRecord::Base

	has_many :product_deliveryships, :dependent => :destroy
  	has_many :products, :through => :product_deliveryships

scope :like, ->(args) { where("deliveries.name like '%#{args}%' OR
                                                       deliveries.description like '%#{args}%' OR
                                                       deliveries.price like '%#{args}%'")}

end

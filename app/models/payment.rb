class Payment < ActiveRecord::Base

	has_many :product_paymentships, :dependent => :destroy
  	has_many :products, :through => :product_paymentships

  scope :like, ->(args) { where("payments.name like '%#{args}%' OR
                                                       payments.description like '%#{args}%' OR
                                                       payments.dayline like '%#{args}%'")}
end

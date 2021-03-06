class Account < ActiveRecord::Base
	has_many :shoppingcarts, :dependent => :destroy
	has_many :salecarts, :dependent => :destroy
	has_many :orders
	has_many :messages
	has_many :product_register
	has_many :replies
	has_many :product_messages, :dependent => :destroy
	has_many :order_messages, :dependent => :destroy
	has_one :newsletter_email, foreign_key: "email", primary_key: "email"
	belongs_to :account_level
	# validates :email, presence: true, format: /@/ , uniqueness: true
	# validates :email_backup, presence: true, format: /@/ , uniqueness: true
	

	# validates :password, presence: true, length: { minimum: 4}
	has_secure_password


	# validates :account_name, presence: true
	
# devise :database_authenticatable, :registerable,
 #         :recoverable, :rememberable, :trackable, :validatable,
 #         :omniauthable,:omniauth_providers => [:facebook]
 # 	def self.from_omniauth(auth)
 #    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
 #      user.email = auth.info.email
 #      user.password = Devise.friendly_token[0,20]
 #    end
 #  end
end

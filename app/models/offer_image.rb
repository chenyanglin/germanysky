class OfferImage < ActiveRecord::Base
   belongs_to :specialoffer, foreign_key: "specialoffer_id"
   has_attached_file :upload,
  :styles => 
  { 
    # small: '10%'  ,
    # medium: '50%'  ,
    original: '-auto-orient' 
  },
    default_url: '/app/assets/images/:id.jpg',
    :use_timestamp => false,
    # url: '/public/image/:id.jpg',
    # path: '/public/image/:id.jpg',
    :path => ":rails_root/app/assets/images/specialoffers/:attachment/:id/:filename",
    :url => "specialoffers/:attachment/:id/:filename",
   hash_secret: 'get_from_rake_secret'

  validates_attachment :upload, content_type: { content_type: /\Aimage\/.*\Z/ },
                                size: { in: 0..40.megabytes }
  after_create :default_values
  def default_values
    self.name ||= self.id
    self.save
  end
end

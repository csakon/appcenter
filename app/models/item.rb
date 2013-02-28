class Item < ActiveRecord::Base
  attr_accessible :description, :image

  validates :description, presence: true
  validates :user_id, presence: true
  validates_attachment :image, presence: true,
  							   content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif']},
  							   size: { less_than: 5.megabytes }

  belongs_to :user
  
  has_attached_file :image, 
  	:storage => :s3,
  	:s3_credentials => {
    	:bucket => ENV['AWS_BUCKET'],
    	:access_key_id => ENV['AWS_ACCESS_KEY_ID'],
    	:secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
  	},
  	styles: { medium: "300x300>"}


end

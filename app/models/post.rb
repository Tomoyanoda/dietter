class Post < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :user
  
  validates :content, presence: true
  validates :weight,numericality: {greater_than: 0, less_than: 500 }
end

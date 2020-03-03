class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user
  
  validates :content, presence: true, length: { maximum: 140 }
  validates :weight, presence: true
end

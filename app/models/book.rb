class Book < ApplicationRecord
  validates :title, presence: true ,length:{maximum:30}
  validates :explain, presence: true , length:{maximum:255}
  mount_uploader :image, ImageUploader
  
  belongs_to :user
  belongs_to :order, optional: true
  
  has_many :orders 
  has_many :wanters, through: :orders , source: :user 
  
  has_many :messages, dependent: :destroy
  
end

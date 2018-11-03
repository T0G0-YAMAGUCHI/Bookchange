class Book < ApplicationRecord
  validates :title , presence: true ,length:{maximum:30}
  mount_uploader  :image, ImageUploader
  belongs_to :user
  
  def self.search(search)
    if search
      Book.where(["title LIKE?" , "%#{search}%" ])
    else
      Book.all
    end
  end
  
  has_many :reverces_of_orders , class_name:"Order" , foreign_key:"user_id"

end

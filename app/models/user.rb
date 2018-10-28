class User < ApplicationRecord
  before_action { self.email.downcase!}
  validates :name , presence: true , length:{maximum:30}
  validates :emamil ,  presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  
  validates :point , presence: true 
  
  has_secure_password
end

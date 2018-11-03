class Exhibitor < ApplicationRecord
  belongs_to :book
  belongs_to :user
  
  validates :explain , presence: true ,length:{maximum:255}
end

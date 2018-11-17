class User < ApplicationRecord
  before_save { self.email.downcase!}
  validates :name , presence: true , length:{maximum:30}
  validates :email , presence: true, length:{maximum:50} ,
                     format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                     uniqueness: { case_sensitive: false }
  
  validates :point , presence: true
  
  has_many :books
  
  has_many :orders 
  has_many :want_books , through: :orders , source: :book 
  
  has_many :messages , dependent: :destroy
 
  def purchased_books
    self.want_books.where(order_id: Order.where(user_id: self.id).pluck(:id))
  end
  
  def want(book)
    self.orders.find_or_create_by(book_id: book.id)
  end
  
  def unwant(book)
    want = self.orders.find_by(book_id: book.id)
    want.destroy if want
  end

  def want?(book)
    self.want_books.include?(book)
  end
  

  
  has_secure_password
end

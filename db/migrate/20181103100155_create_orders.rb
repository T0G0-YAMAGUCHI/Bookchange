class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.boolean    :check ,default: false 
      
      t.timestamps
      t.index [:user_id, :book_id], unique: true
    end
  end
end

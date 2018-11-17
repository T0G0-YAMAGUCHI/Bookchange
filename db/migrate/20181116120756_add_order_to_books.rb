class AddOrderToBooks < ActiveRecord::Migration[5.0]
  def change
    add_reference :books, :order, foreign_key: true
  end
end

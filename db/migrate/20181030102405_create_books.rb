class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :image
      t.string :explain
      t.references :user , foregin_key: true
      

      t.timestamps
    end
  end
end

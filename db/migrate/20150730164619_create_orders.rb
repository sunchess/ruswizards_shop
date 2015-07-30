class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :address
      t.string :phone
      t.string :fullname
      t.integer :user_id

      t.timestamps null: false
    end
  end
end

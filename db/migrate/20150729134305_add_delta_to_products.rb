class AddDeltaToProducts < ActiveRecord::Migration
  def change
    add_column :products, :delta, :boolean
  end
end

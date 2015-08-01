class AddDiscountToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :discount_count, :integer
    add_column :categories, :discount_percent, :float
  end
end

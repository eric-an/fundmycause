class AddCategoryToCauses < ActiveRecord::Migration
  def change
    add_column :causes, :category_id, :integer
  end
end

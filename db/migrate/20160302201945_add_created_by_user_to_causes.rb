class AddCreatedByUserToCauses < ActiveRecord::Migration
  def change
    add_column :causes, :created_by_user, :integer
  end
end

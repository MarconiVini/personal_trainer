class AddAdminIdToPersonals < ActiveRecord::Migration
  def change
    add_column :personals, :admin_id, :integer
  end
end

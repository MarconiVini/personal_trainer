class AddActiveToPersonals < ActiveRecord::Migration
  def change
    add_column :personals, :active, :boolean
  end
end

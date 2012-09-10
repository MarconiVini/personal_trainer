class AddUrlToPersonals < ActiveRecord::Migration
  def change
    add_column :personals, :url, :string
  end
end

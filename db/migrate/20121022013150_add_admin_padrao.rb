class AddAdminPadrao < ActiveRecord::Migration
  def up
    u = Admin.new
    u.name = "Marcos Vinicius Cardoso Santini"
    u.email = "cardosounicamp@gmail.com"
    u.password = 'xtaisax'
    u.password_confirmation = "xtaisax"
    u.admin_level = '1'
    u.save
  end

  def down
  end
end

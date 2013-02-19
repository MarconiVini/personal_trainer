class AddPasswordToPersonal < ActiveRecord::Migration
  def change
    add_column :personals, :password_digest, :string, :default => "$2a$10$KCMgHNeplL2zT5yydIlgGOja48mj8CDR2fasPADdY2K/lJwXeC3LS"
    
  end
end

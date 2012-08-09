class CreateAdminSessions < ActiveRecord::Migration
  def change
    create_table :admin_sessions do |t|
      
      t.string    :id_session_hash
      t.integer   :id_admin

      t.timestamps
    end
  end
end

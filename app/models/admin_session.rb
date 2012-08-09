class AdminSession < ActiveRecord::Base
  attr_accessible :id_session_hash, :id_admin
  
  validates :id_session_hash, presence: true
  validates :id_admin, presence: true  
  
end

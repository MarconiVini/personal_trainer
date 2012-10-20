class Admin < ActiveRecord::Base
  has_many :personals 
  
  attr_accessible :name, :email, :password, :password_confirmation, :admin_level
  attr_accessor :password_confirmation
  
  has_secure_password
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name, presence: true, length: {minimum: 3}
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true
  validates :admin_level, presence: true
  
  
  def self.admin_levels
    [['Escolha um nivel de administrador', ''], ['Administrador superior', 1], ["Administrador de Personals", 2], ["Administrador de dados", 3] ]
  end
  
  def authorization_test(nivel_acesso)
    #verifica se o admin possui a autorizacao indicada    
    if self.admin_level.to_s <= nivel_acesso.to_s
      return true
    else
      return false
    end
  end
  
end

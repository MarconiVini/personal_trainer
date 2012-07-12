class Admin < ActiveRecord::Base
  def self.admin_levels
    [['Administrador superior', 1], ["Administrador de Personals", 2], ["Administrador de dados", 3] ]
  end
  
  attr_accessible :name, :email, :password, :password_confirmation, :admin_level
  attr_accessor :password_confirmation
  
  has_secure_password
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name, presence: true, length: {minimum: 3}
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true
  validates :admin_level, presence: true
  
end

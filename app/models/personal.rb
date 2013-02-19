class Personal < ActiveRecord::Base
  belongs_to :admin
  before_create :default_value
  attr_accessible :name, :email, :url, :active, :password, :password_confirmation
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  has_secure_password
  
  validates :name, presence: true, length: {minimum: 3}
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 6}, on: :create
  validates :password_confirmation, presence: true, on: :create
  
  def testa_url_ou_return_sugestao
    personal_full_name = self.name
        #Divide o nome do Personal em um array separado pelos espaços tirando acentos
    personal_full_name = personal_full_name.remover_acentos.downcase.split(' ')                                                  
        #pegar o primeiro nome e procurar esta string no banco no campo url
    search_url = Personal.find_by_url(personal_full_name[0].to_s)
    
    #if else criado para evitar que o search_url retorne apenas nulo do banco de dados
    if search_url == nil
      search_url = ""
    else 
      search_url = search_url.url
    end
    
    if personal_full_name[0] == search_url
        #se nome do personal já existe ele retorna um array de elementos de sugestões de urls ou então retorna false
      return generate_url(personal_full_name)
    else
      return personal_full_name[0]
    end
    
  end
  
  def set_to_inactive                                                           #Inativa uma conta de personal
    self.active = false
  end
  
  def set_to_active                                                             #Re-ativa uma conta de personal
    self.active = true
  end
  
  def default_value
    self.active ||= true
  end
  
  private 
  
  def generate_url(personal_full_name)
    first_name = String.new                                                     #primeiro nome do personal
    dicas_de_url = Array.new                                                    #Array com as dicas de url
    personal_full_name.each do |name|
      if first_name.empty?                                            
        first_name = name                                                       #recupera o primeiro nome do personal
        dicas_de_url << "#{first_name}-personal"                                #concatena o primeiro nome com personal
      else
        dicas_de_url << "#{first_name}-#{name}"                                 #concatena os nomes do personal
      end 
    end
    #depois deste ponto já tenho uma array com todas as dicas das url dos personal trainers.  
    return dicas_de_url
  end
  
end


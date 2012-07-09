require 'spec_helper'

describe "StaticPages" do
  describe "Admin index" do
    it "Deve ter um titulo h1" do
      visit root_path
      page.should have_selector('h1', text: 'Bem vindo ao sistema gerenciador Personal Trainer')
    end
    it "Deve ter a descricao da index" do
      visit root_path
      page.should have_selector('p', text: 'Gerencie todos os componentes do app.')
    end
  end
  
end

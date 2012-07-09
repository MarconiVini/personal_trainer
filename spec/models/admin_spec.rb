require 'spec_helper'

describe Admin do
   before { @admin = Admin.new(name: "Example User", email: "user@example.com", password: "testee", password_confirmation: "testee") }
   
   subject {@admin}
   
   it{should respond_to :name}
   it{should respond_to :email}
   it{should respond_to :password}
   it{should respond_to :password_confirmation}
   it{should respond_to :password_digest }
   
   
   describe "O Nome nao deve ser branco" do
     before { @admin.name = " "}
     it {should_not be_valid}
   end
   
   describe "O Email nao deve ser branco" do
     before { @admin.email = " "}
     it {should_not be_valid}
   end
   
   describe "Quando o Email ja foi tomado por outra pessoa" do
     before do
      admin_with_same_email = @admin.dup
      admin_with_same_email.email = @admin.email.upcase
      admin_with_same_email.save
     end
     it{should_not be_valid}
   end
   
   #Parte das senhas
   describe "Quando o Password esta branco" do
     before { @admin.password = @admin.password_confirmation = " " }
     it{should_not be_valid}
   end
   
   describe "Quando o Password esta diferente da confirmacao" do
     before { @admin.password_confirmation = "diferente" }
     it{should_not be_valid}
   end
   
   describe "Quando o Password esta nulo" do
     before { @admin.password = nil }
     it{should_not be_valid}
   end
   
   describe "usando um password muito pequeno" do
     before { @admin.password = @admin.password_confirmation = "a" * 5 }
     it { should be_invalid }
  end
end



























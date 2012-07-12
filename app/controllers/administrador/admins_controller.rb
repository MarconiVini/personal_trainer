class Administrador::AdminsController < ApplicationController
  def index
    @admin = Admin.all
  end

  def new
    @admin = Admin.new
    @admin_level = Admin.admin_levels
  end

  def create
    @admin = Admin.new(params[:admin])
    @admin.admin_level = params[:admin_level]
    @admin.save
    flash[:notice] = "O Admin \"#{@admin.name}\" foi criado com sucesso !"
    redirect_to :action => :index
  end

  def show

  end

  def edit
    @admin = Admin.find(params[:id])
    @admin_level = Admin.admin_levels
  end
  
  def update
    @admin = Admin.find(params[:id])
    @admin.update_attributes!(params[:admin])
    flash[:notice] = "O Admin \"#{@admin.name}\" foi editado com sucesso !"
    redirect_to :action => :index
  end
  
  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy
    flash[:notice] = "O Admin \"#{@admin.name}\" foi deletado !"
    redirect_to :action => :index
  end

end






class Administrador::AdminsController < ApplicationController
  def index
    @admin = Admin.all
  end

  def new
    @admin = Admin.new
    @admin_level = Admin.admin_levels
  end

  def create
    @admin_level = Admin.admin_levels
    @admin = Admin.new(params[:admin])    
    if @admin.save
      flash[:notice] = "O Admin \"#{@admin.name}\" foi criado com sucesso !"
      redirect_to :action => :index
    else
      render :action => :new, admin_level: @admin_level
    end
  end

  def show

  end

  def edit
    @admin = Admin.find(params[:id])
    @admin_level = Admin.admin_levels
  end

  def update
    @admin = Admin.find(params[:id])
    @admin_level = Admin.admin_levels
    if @admin.update_attributes(params[:admin])
      flash[:notice] = "O Admin \"#{@admin.name}\" foi editado com sucesso !"
      redirect_to :action => :index
    else
      render :action => :edit, admin_level: @admin_level
    end
  end

  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy
    flash[:notice] = "O Admin \"#{@admin.name}\" foi deletado !"
    redirect_to :action => :index
  end

end


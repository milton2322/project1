class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
    
  before_action :set_categories
    
  protected
  #con esto validamos el tipo de usuario a nivel de controlador   
  #Estos metodos estan usando los metodos de permission_concern
  #Lo que hace es si el usuario esta logeado determinar si tiene permisos de editor, admin y si no que regrese a la ruta raiz Home 'root_path'
  
  def authenticate_editor!
    redirect_to root_path unless user_signed_in? && current_user.is_editor?
  end

  def authenticate_admin!
    redirect_to root_path unless user_signed_in? && current_user.is_admin?
  end
    
  private 
  
  def set_categories
      @categories = Category.all
  end
end

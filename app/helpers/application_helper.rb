module ApplicationHelper
  def main_menu
    pages = {
      "Visualizar administradores" => administrador_admins_path,
      "Visualizar Personals" => administrador_personals_path
    }
    pages.map do |key, value|
      classnames = %( class="active") if "/#{params[:controller]}" == value
      "<li#{classnames}>#{link_to(key, value)}</li>"
    end
  end
end

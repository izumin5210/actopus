module ApplicationHelper
  def staff_menu_item(icon, name, path)
    link_to(fa_icon("#{icon} fw") { |i| "#{i} #{name}" }, path, class: "list-group-item")
  end
end

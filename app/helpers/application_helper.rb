module ApplicationHelper
  def staff_menu_item(name, path)
    link_to(name, path, class: "list-group-item")
  end
end

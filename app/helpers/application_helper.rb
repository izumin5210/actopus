module ApplicationHelper
  def staff_menu_item(icon, name, path)
    link_to(fa_icon("#{icon} fw") { |i| "#{i} #{name}" }, path, class: "list-group-item")
  end

  def staff_renew_btn(path)
    link_to(fa_icon("refresh fw") { |i| "#{i} 更新" }, path, class: "btn btn-primary")
  end

  def staff_destroy_btn(path)
    link_to(fa_icon("trash fw") { |i| "#{i} 削除" }, path, class: "btn btn-primary")
  end

  def timetable_header(icon, name)
    fa_icon("#{icon} fw") { |i| "#{i} #{name}" }
  end
end

module ApplicationHelper
  def staff_menu_item(icon, name, path, option = {})
    link_to(fa_icon("#{icon} fw") { |i| "#{i} #{name}" }, path, option.merge(class: "list-group-item"))
  end

  def staff_renew_btn(path)
    link_to(fa_icon("refresh fw") { |i| "#{i} 更新" }, path, class: "btn btn-primary")
  end

  def staff_destroy_btn(path)
    link_to(fa_icon("trash fw") { |i| "#{i} 削除" }, path, class: "btn btn-primary")
  end

  def content_header(icon, name)
    content_tag(:h2, fa_icon("#{icon} fw") { |i| "#{i} #{name}" }, class: "header-sub")
  end

  def fa_stack_btn(link, alt, icon)
    link_to("#{link}", alt: "#{alt}") do
      content_tag(:span, class: 'fa-stack fa-4x', data: { toggle: 'tooltip', placement: 'bottom' }, title: "#{alt}") do
        concat fa_icon('circle stack-2x')
        concat fa_icon("#{icon} stack-1x")
      end
    end
  end

  def datetime_md(datetime)
    return datetime unless datetime
    datetime.strftime("%m/%d")
  end

  def datetime_mdhm(datetime)
    return datetime unless datetime
    datetime.strftime("%m/%d %H:%M")
  end
end

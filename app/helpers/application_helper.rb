module ApplicationHelper
  def nav_item_classes
    "relative top-[2px]"
  end

  def nav_item_link_classes(nav_item_path)
    classes = %w[p-2 no-underline]
    classes << "border-b-4 border-emerald-600" if current_page?(nav_item_path)
    classes.join(" ")
  end
end

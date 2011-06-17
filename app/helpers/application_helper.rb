module ApplicationHelper

  def logo
    content_tag(:div, content_tag(:div, "Reblog"), :class => "logo round")
  end
end

module ActiveAdmin::ViewsHelper
  def tag_links model
  	model.tag_counts.reduce "" do |str, tag|
  		str + " " + (link_to tag, "#", class: 'hint_tag_link')
  	end.html_safe
  end
end
module ApplicationHelper
  def title title
    content_for :title do
      h(title.to_s)
    end
  end

  def first_paragraph text
    raw Nokogiri::HTML.parse(text).css('p').first.to_html
  end

  # all except first
  def rest_paragraphs text
    nodeset =  Nokogiri::HTML.parse(text).css('p')
    nodeset.shift
    raw nodeset.to_html
  end

  def submenu_link_active_if condition, text, path
    css_classes = %w(black sub-menu-link)
    css_classes << "sub-menu-link-select" if condition
    link_to text, path, class: css_classes
  end
end

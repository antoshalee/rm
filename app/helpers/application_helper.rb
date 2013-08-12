module ApplicationHelper
  def first_paragraph text
    raw Nokogiri::HTML.parse(text).css('p').first.to_html
  end

  # all except first
  def rest_paragraphs text
    nodeset =  Nokogiri::HTML.parse(text).css('p')
    nodeset.shift
    raw nodeset.to_html
  end
end

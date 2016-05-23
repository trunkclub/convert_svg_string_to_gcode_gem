require 'nokogiri'

class ParseSVGString
  def self.perform(svg_string)
    return Nokogiri::XML.parse(svg_string)
  end
end

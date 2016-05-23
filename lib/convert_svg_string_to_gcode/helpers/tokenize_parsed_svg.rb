
class TokenizeParsedSVG
  def self.perform(parsed_svg)
    return (parsed_svg.xpath('//path').attribute("d").value.split(%r{([A-Z ])}) - ["", " "])
  end
end

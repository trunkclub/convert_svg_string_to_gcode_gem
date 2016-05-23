require 'convert_svg_string_to_gcode/helpers/parse_svg_string'

RSpec.describe ParseSVGString do

  it 'parses svg string' do
    svg_as_string = SpecConstants::TEST_SVG_AS_STRING
    parsed_svg = ParseSVGString.perform(svg_as_string)
  end

end

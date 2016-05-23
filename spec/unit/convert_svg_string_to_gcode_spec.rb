require 'spec_helper'
require 'convert_svg_string_to_gcode'
require 'convert_svg_string_to_gcode/helpers/parse_svg_string'
require 'convert_svg_string_to_gcode/helpers/tokenize_parsed_svg'

RSpec.describe ConvertSVGStringToGCode do
  let(:svg_as_string) { SpecConstants::TEST_SVG_AS_STRING }

  it 'converts SVG string into G-Code' do
    gcode = ConvertSVGStringToGCode.perform(svg_as_string)
    expect(gcode).to eq(SpecConstants::EXPECTED_GCODE_TEST_SVG_OUTPUT)
  end
end

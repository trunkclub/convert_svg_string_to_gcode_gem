require 'spec_helper'
require 'convert_svg_string_to_gcode/helpers/read_svg_to_string'

RSpec.describe ReadSVGToString do
  let(:svg_file) { File.open('spec/fixtures/test.svg') }

  it 'reads in an SVG file and outputs a string' do
    svg_as_string = ReadSVGToString.perform(svg_file)
    expect(svg_as_string).to eq(SpecConstants::TEST_SVG_AS_STRING)
  end
end

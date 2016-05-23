require 'convert_svg_string_to_gcode/helpers/tokenize_parsed_svg'
require 'factory_helper'

RSpec.describe TokenizeParsedSVG do
  let(:parsed_svg) { FactoryHelper.parsed_svg }

  it 'takes a parsed SVG and returns tokens' do
    svg_tokens = TokenizeParsedSVG.perform(parsed_svg)
    expect(svg_tokens).to eq(SpecConstants::TEST_SVG_TOKENS)
  end
end

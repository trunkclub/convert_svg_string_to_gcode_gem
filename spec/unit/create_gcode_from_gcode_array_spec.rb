require 'spec_helper'
require 'factory_helper'
require 'convert_svg_string_to_gcode/helpers/create_gcode_from_gcode_array'


RSpec.describe CreateGCodeFromGCodeArray do
  let(:gcode_array) { FactoryHelper.gcode_array }

  it 'converts G-Code Array to G-Code' do
     gcode = CreateGCodeFromGCodeArray.perform(gcode_array)
     expect(gcode).to eq(SpecConstants::EXPECTED_GCODE_TEST_SVG_OUTPUT)
  end
end

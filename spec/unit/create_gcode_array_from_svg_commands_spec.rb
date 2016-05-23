require 'convert_svg_string_to_gcode/helpers/create_gcode_array_from_svg_commands'
require 'spec_helper'
require 'factory_helper'

RSpec.describe CreateGCodeArrayFromSVGCommands do
  let(:adjusted_svg_commands) { FactoryHelper.adjusted_svg_commands }

  it 'creates a G-Code array from SVG commands' do
    gcode_array = CreateGCodeArrayFromSVGCommands.perform(adjusted_svg_commands)
    expect(gcode_array).to eq(SpecConstants::TEST_GCODE_ARRAY)
  end

end

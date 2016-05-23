require 'convert_svg_string_to_gcode/helpers/adjust_svg_commands_for_plotter'
require 'spec_helper'
require 'factory_helper'

RSpec.describe AdjustSVGCommandsForPlotter do
  let(:svg_commands) { FactoryHelper.svg_commands }
  let(:spec_adjusted_commands) { SpecConstants::TEST_ADJUSTED_COMMANDS }

  it 'adjusts SVG commands for the plotter' do
    adjusted_svg_commands = AdjustSVGCommandsForPlotter.perform(svg_commands, ConversionConstants::PROPORTION)

    expect(adjusted_svg_commands.first.p1x).to eq(spec_adjusted_commands.first.p1x)
    expect(adjusted_svg_commands.first.p1y).to eq(spec_adjusted_commands.first.p1y)

    expect(adjusted_svg_commands.second.cp0x).to eq(spec_adjusted_commands.second.cp0x)
    expect(adjusted_svg_commands.second.cp0y).to eq(spec_adjusted_commands.second.cp0y)
    expect(adjusted_svg_commands.second.cp1x).to eq(spec_adjusted_commands.second.cp1x)
    expect(adjusted_svg_commands.second.cp1y).to eq(spec_adjusted_commands.second.cp1y)
    expect(adjusted_svg_commands.second.p0x).to eq(spec_adjusted_commands.second.p0x)
    expect(adjusted_svg_commands.second.p0y).to eq(spec_adjusted_commands.second.p0y)
    expect(adjusted_svg_commands.second.p1x).to eq(spec_adjusted_commands.second.p1x)
    expect(adjusted_svg_commands.second.p1y).to eq(spec_adjusted_commands.second.p1y)
  end
end

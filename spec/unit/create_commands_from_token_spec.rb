require 'active_support'
require 'active_support/core_ext'
require 'convert_svg_string_to_gcode/helpers/create_commands_from_tokens'
require 'factory_helper'

RSpec.describe CreateCommandsFromTokens do
  let(:svg_tokens) { SpecConstants::TEST_SVG_TOKENS }
  let(:spec_commands) { SpecConstants::TEST_SVG_COMMANDS }

  it 'creates command array from tokens' do
    commands = CreateCommandsFromTokens.perform(svg_tokens)

    expect(spec_commands.first.p1x).to eq(spec_commands.first.p1x)
    expect(spec_commands.first.p1y).to eq(spec_commands.first.p1y)

    expect(spec_commands.second.cp0x).to eq(spec_commands.second.cp0x)
    expect(spec_commands.second.cp0y).to eq(spec_commands.second.cp0y)
    expect(spec_commands.second.cp1x).to eq(spec_commands.second.cp1x)
    expect(spec_commands.second.cp1y).to eq(spec_commands.second.cp1y)
    expect(spec_commands.second.p0x).to eq(spec_commands.second.p0x)
    expect(spec_commands.second.p0y).to eq(spec_commands.second.p0y)
    expect(spec_commands.second.p1x).to eq(spec_commands.second.p1x)
    expect(spec_commands.second.p1y).to eq(spec_commands.second.p1y)
  end

end

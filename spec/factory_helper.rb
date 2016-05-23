require 'convert_svg_string_to_gcode/helpers/parse_svg_string'
require 'convert_svg_string_to_gcode/helpers/tokenize_parsed_svg'
require 'convert_svg_string_to_gcode/helpers/create_commands_from_tokens'
require 'convert_svg_string_to_gcode/helpers/adjust_svg_commands_for_plotter'
require 'convert_svg_string_to_gcode/helpers/create_gcode_array_from_svg_commands'
require 'convert_svg_string_to_gcode/helpers/create_gcode_from_gcode_array'
require 'fixtures/spec_constants'

class FactoryHelper
  def self.parsed_svg
    ParseSVGString.perform(SpecConstants::TEST_SVG_AS_STRING)
  end

  def self.svg_tokens
    TokenizeParsedSVG.perform(parsed_svg)
  end

  def self.svg_commands
    CreateCommandsFromTokens.perform(svg_tokens)
  end

  def self.adjusted_svg_commands
    AdjustSVGCommandsForPlotter.perform(svg_commands, ConversionConstants::PROPORTION )
  end

  def self.gcode_array
    CreateGCodeArrayFromSVGCommands.perform(adjusted_svg_commands)
  end
end

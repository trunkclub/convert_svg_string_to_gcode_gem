require 'convert_svg_string_to_gcode/helpers/parse_svg_string'
require 'convert_svg_string_to_gcode/helpers/tokenize_parsed_svg'
require 'convert_svg_string_to_gcode/helpers/create_commands_from_tokens'
require 'convert_svg_string_to_gcode/helpers/adjust_svg_commands_for_plotter'
require 'convert_svg_string_to_gcode/helpers/create_gcode_array_from_svg_commands'
require 'convert_svg_string_to_gcode/helpers/create_gcode_from_gcode_array'

class ConvertSVGStringToGCode

  def self.perform(svg_as_string)
    parsed_svg            = ParseSVGString.perform(svg_as_string)
    svg_tokens            = TokenizeParsedSVG.perform(parsed_svg)
    svg_commands          = CreateCommandsFromTokens.perform(svg_tokens)
    adjusted_svg_commands = AdjustSVGCommandsForPlotter.perform(svg_commands, ConversionConstants::PROPORTION)
    gcode_array           = CreateGCodeArrayFromSVGCommands.perform(adjusted_svg_commands)
    CreateGCodeFromGCodeArray.perform(gcode_array)
  end

end

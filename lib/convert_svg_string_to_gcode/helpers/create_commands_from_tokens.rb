require 'convert_svg_string_to_gcode/models/svg_command'

class CreateCommandsFromTokens
  def self.perform(svg_tokens)
    last_command = SVGCommand.new(
      type: ConversionConstants::MOVE,
      p1x: 0.0,
      p1y: 0.0,
      p0x: 0.0,
      p0y: 0.0,
      p1x: 0.0,
      p1y: 0.0
    )

    svg_commands = svg_tokens.each_with_index.map do |token, i|
      svg_command = nil

      if token.match(%r{[#{ConversionConstants::GCODE_COMMANDS}]})
        case token
        when ConversionConstants::MOVE
          svg_command = SVGCommand.new(
            type: ConversionConstants::MOVE,
            p0x: last_command.p1x,
            p0y: last_command.p1y,
            p1x: svg_tokens[i+1],
            p1y: svg_tokens[i+2]
          )
        when ConversionConstants::LINE_TO
          svg_command = SVGCommand.new(
            type: ConversionConstants::LINE_TO,
            p0x: last_command.p1x,
            p0y: last_command.p1y,
            p1x: svg_tokens[i+1],
            p1y: svg_tokens[i+2]
          )
        when ConversionConstants::CURVE
          svg_command = SVGCommand.new(
            type: ConversionConstants::CURVE,
            p0x:  last_command.p1x,
            p0y:  last_command.p1y,
            cp0x: svg_tokens[i+1],
            cp0y: svg_tokens[i+2],
            cp1x: svg_tokens[i+3],
            cp1y: svg_tokens[i+4],
            p1x:  svg_tokens[i+5],
            p1y:  svg_tokens[i+6]
          )
        end
      end
      last_command = svg_command if svg_command
      svg_command
    end
    svg_commands.compact
  end

end

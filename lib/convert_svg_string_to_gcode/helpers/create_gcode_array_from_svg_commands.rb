require 'convert_svg_string_to_gcode/constants/plotter_config'
class CreateGCodeArrayFromSVGCommands
  def self.perform(commands, options = {step: 0.20})
    start_point = nil
    step=options[:step]

    gcode_array = commands.map do |c|
      case c.type
      when ConversionConstants::MOVE
        move_to_point(c)
      when ConversionConstants::LINE_TO
        draw_to_point(c)
      when ConversionConstants::CURVE
        create_gcode_path_from_bezier(c, step)
      else
        throw Error
      end
    end
  end

  def self.move_to_point(new_point)
    x_value = new_point.p1x
    y_value = new_point.p1y
    command = ["G0 X#{x_value} Y#{y_value} #{PlotterConfig::Z_UP}"]
    return command
  end

  def self.draw_to_point(new_point)
    x_value = new_point.p1x
    y_value = new_point.p1y
    command = ["G1 X#{x_value} Y#{y_value} #{PlotterConfig::Z_DOWN}"]
    return command
  end

  def self.create_gcode_path_from_bezier(svg_command, step)

    p0x  = svg_command.p0x
    p0y  = svg_command.p0y
    cp0x = svg_command.cp0x
    cp0y = svg_command.cp0y
    cp1x = svg_command.cp1x
    cp1y = svg_command.cp1y
    p1x  = svg_command.p1x
    p1y  = svg_command.p1y

    t  = step

    gcode_array = []

    while t<1 do
      ax = ( (1 - t) * p0x ) + (t * cp0x)
      ay = ( (1 - t) * p0y ) + (t * cp0y)
      bx = ( (1 - t) * cp0x ) + (t * cp1x)
      by = ( (1 - t) * cp0y ) + (t * cp1y)
      cx = ( (1 - t) * cp1x ) + (t * p1x)
      cy = ( (1 - t) * cp1y ) + (t * p1y)

      dx = ( (1 - t) * ax ) + (t * bx)
      dy = ( (1 - t) * ay ) + (t * by)
      ex = ( (1 - t) * bx ) + (t * cx)
      ey = ( (1 - t) * by ) + (t * cy)

      new_point_x = ( (1 - t) * dx ) + (t * ex)
      new_point_y = ( (1 - t) * dy ) + (t * ey)
      gcode_array << "G1 X#{new_point_x} Y#{new_point_y} #{PlotterConfig::Z_DOWN}"
      t+=step
    end
   return gcode_array
  end

end

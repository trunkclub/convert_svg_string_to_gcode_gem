require 'convert_svg_string_to_gcode/models/svg_command'
require 'convert_svg_string_to_gcode/helpers/box_helper'

class AdjustSVGCommandsForPlotter
  def self.perform(svg_commands,proportion=ConversionConstants::PROPORTION)
    skewed_svg_commands = resize_svg_commands_by_proportion(svg_commands, proportion)
    min_x, min_y = get_min_x_y(skewed_svg_commands)
    max_x, max_y = get_max_x_y(skewed_svg_commands)
    buffered_svg_commands = add_margin_to_svg_commands(skewed_svg_commands, min_x, min_y)
    optimize_commands(buffered_svg_commands)
  end

  def self.optimize_commands(svg_commands)
    grouped_non_move_commands = group_commands_and_remove_moves(svg_commands)
    ordered_svg_commands = sort_commands_ascending_by_x(grouped_non_move_commands)
    sorted_svg_commands = BoxHelper.sort_commands_into_boxes(ordered_svg_commands)
    add_moves_back_to_svg_commands(sorted_svg_commands)
  end

  def self.resize_svg_commands_by_proportion(svg_commands, proportion)
    svg_commands.map do |command|
      command.adjust_by_proportion(proportion)
    end
  end

  def self.get_min_x_y(svg_commands)
    min_x = nil
    min_y = nil
    svg_commands.map do |command|
      command_min_x = [command.p0x, command.p1x].min
      min_x = command_min_x if  !min_x || command_min_x<min_x || min_x == 0.0

      command_min_y = [command.p0y, command.p1y].min
      min_y = command_min_y if  !min_y || command_min_y<min_y || min_y == 0.0
    end
    return min_x, min_y
  end

  def self.get_max_x_y(svg_commands)
    max_x = nil
    max_y = nil

    svg_commands.map do |command|
      command_max_x = [command.p0x, command.p1x].max
      max_x = command_max_x if  !max_x || command_max_x>max_x || max_x == 0.0

      command_max_y = [command.p0y, command.p1y].max
      max_y = command_max_y if  !max_y || command_max_y>max_y || max_y == 0.0
    end
    return max_x, max_y
  end

  def self.add_margin_to_svg_commands(svg_commands, min_x, min_y, buffer=20.0)
    x_margin = buffer-min_x
    y_margin = buffer-min_y

    svg_commands.map do |command|
      command.add_margins(x_margin, y_margin)
    end
  end

  def self.sort_commands_ascending_by_x(svg_commands)
    svg_commands.sort do |a,b|
      a.first.p0x <=> b.first.p0x
    end
  end

  def self.add_moves_back_to_svg_commands(svg_commands)
    commands_with_moves = svg_commands.map do |boxes|
        boxes.map do |commands|
          move_to_command = SVGCommand.new(
            type: ConversionConstants::MOVE,
            p1x: commands.first.p0x,
            p1y: commands.first.p0y
          )
          [move_to_command, commands.flatten]
        end
    end
    commands_with_moves.flatten
  end

  def self.group_commands_and_remove_moves(svg_commands)
    svg_commands
      .chunk { |cmd| cmd.type == 'M' }
      .reject { |enum| enum[0] }
      .map { |enum| enum[1] }
  end

end

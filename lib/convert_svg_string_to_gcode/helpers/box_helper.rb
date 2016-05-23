require 'convert_svg_string_to_gcode/models/box'
require 'convert_svg_string_to_gcode/helpers/adjust_svg_commands_for_plotter'

class BoxHelper

  def self.sort_commands_into_boxes(svg_commands, rows: 10, columns: 3)

    boxes = create_write_boxes(svg_commands, rows, columns)
    boxed_commands = boxes.map { |bc| [] }

    box_order = []

    boxes.each_slice(rows).with_index do |box_group, i|
      if i.even?
        box_order << box_group.map { |b| b.box_number }
      else
        box_order << box_group.reverse_each.map { |b| b.box_number }
      end
    end

    box_order_index = {}

    box_order.flatten.each.with_index do |order_number, i|
      box_order_index[order_number] = i
    end

    svg_commands.each do |command|
      box_order.flatten.each do |box_number|
        next unless command_is_within_box?(command, boxes[box_number])
        boxed_commands[box_order_index[box_number]] << command
      end
    end
    boxed_commands
  end

  def self.command_is_within_box?(command, box)
    command.first.p0x.between?(box.x_min, box.x_max) &&
      command.first.p0y.between?(box.y_min, box.y_max)
  end

  def self.create_write_boxes(svg_commands, rows = 10, columns= 3)
    x_max, y_max = AdjustSVGCommandsForPlotter.get_max_x_y(svg_commands.flatten)
    x_step = x_max/columns
    y_step = y_max/rows

    x = 0
    y = 0
    boxes = []

    columns.times do |c|
      x_min = x
      x_max = x+x_step
      x = x+x_step

      rows.times do |r|
        y_min = y
        y_max = y+y_step
        y = y+y_step

        boxes << Box.new(
          box_number:rows*c+r,
          x_min: x_min,
          x_max: x_max,
          y_min: y_min,
          y_max: y_max
        )
      end
      y=0
    end
    boxes
  end

  private_class_method :create_write_boxes

end

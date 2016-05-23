
class CreateGCodeFromGCodeArray
  def self.perform(
      gcode_array,
      options = {
        header: PlotterConfig::HEADER,
        footer: PlotterConfig::FOOTER,
      }
    )

    header = options.fetch(:header)
    footer = options.fetch(:footer)

    flattened_gcode_array = header + gcode_array.flatten + footer
    flattened_gcode_array.join("\n")

  end
end

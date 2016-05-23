require 'convert_svg_string_to_gcode/constants/conversion_constants'

class PlotterConfig
  ORIGIN_X = "X0.0"
  ORIGIN_Y = "Y0.0"
  Z_DOWN   = "Z10.0"
  Z_UP     = "Z30.0"
  HEADER   = ["%", "G21", "G00 #{Z_UP}", "G00 X0.0 Y0.0"]
  FOOTER   = ["G00 #{ORIGIN_X} #{ORIGIN_Y} #{Z_UP}", "%"]
end

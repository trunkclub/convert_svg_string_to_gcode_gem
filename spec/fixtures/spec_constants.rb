require 'convert_svg_string_to_gcode/models/svg_command'
require 'convert_svg_string_to_gcode/constants/conversion_constants'

class SpecConstants
  TEST_SVG_AS_STRING             = "<?xml version=\"1.0\" standalone=\"yes\"?>\n<svg width=\"6375\" height=\"4781\">\n<path style=\"stroke:#020202; stroke-linecap: round; stroke-width:5;fill:none;\" d=\"M524 313C537.472 324.483 557.635 339.142 575 343.649\"/>\n</svg>\n"
  TEST_SVG_TOKENS                = [ConversionConstants::MOVE, "524", "313", "C", "537.472",
                                   "324.483", "557.635", "339.142", "575", "343.649"]
  TEST_SVG_COMMANDS              = [SVGCommand.new(type:"M", p0x:0.0, p0y:0.0, p1x:"524", p1y:"313"),SVGCommand.new(type:"C", p0x: "524", p0y:"313", cp0x: "537.472", cp0y: "324.483", cp1x: "557.635", cp1y: "339.142", p1x:"575", p1y:"343.649")]
  TEST_ADJUSTED_COMMANDS         = [SVGCommand.new(type: "M", p1x: 20.0, p1y:20.0), SVGCommand.new(type:"C", p0x:20.0, p0y:20.0, cp0x:29.43040000000002, cp0y:28.038099999999986, cp1x:43.54450000000003, cp1y:38.29939999999999, p1x:55.700000000000045, p1y:41.45429999999999)]

  TEST_GCODE_ARRAY               = [["G0 X20.0 Y20.0 Z30.0"], ["G1 X26.167145600000012 Y25.015007199999996 Z10.0", "G1 X33.13954880000002 Y30.115761599999992 Z10.0", "G1 X40.59837920000004 Y34.85444239999999 Z10.0", "G1 X48.224806400000034 Y38.78322879999999 Z10.0"]]

  EXPECTED_GCODE_TEST_SVG_OUTPUT = "%\nG21\nG00 Z30.0\nG00 X0.0 Y0.0\nG0 X20.0 Y20.0 Z30.0\nG1 X26.167145600000012 Y25.015007199999996 Z10.0\nG1 X33.13954880000002 Y30.115761599999992 Z10.0\nG1 X40.59837920000004 Y34.85444239999999 Z10.0\nG1 X48.224806400000034 Y38.78322879999999 Z10.0\nG00 X0.0 Y0.0 Z30.0\n%"

  TEST_IMAGE_LOCATION            = "https://some-publically-accessible-image-service.com/original_note.jpg"
end

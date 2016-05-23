lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'convert_svg_string_to_gcode'
  s.version     = '0.0.2'
  s.date        = '2016-03-24'
  s.summary     = "Converts SVG paths to GCode strings"
  s.description = "A gem that converts SVG paths (passed in as strings) into GCode strings"
  s.authors     = ["Jesse Furmanek"]
  s.email       = 'jesse@trunkclub.com'
  s.files       = `git ls-files`.split($/)
  s.homepage    =
    'http://rubygems.org/gems/svg_path_to_gcode'
  s.license       = 'MIT'
end

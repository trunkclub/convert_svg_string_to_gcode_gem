Convert SVG String to GCode
===========================

A gem for taking SVG paths and converting them into GCode for CNC routers and Plotters.

Basics
-------
This gem has a very specific functionality – taking [path elements](https://developer.mozilla.org/en-US/docs/Web/SVG/Tutorial/Paths) from an SVG file
parsed as a string and converting that string into [GCode](https://en.wikipedia.org/wiki/G-code), the
programming language used by automated machine tools.

The gem currently supports the move, line, and curve [path commands](https://developer.mozilla.org/en-US/docs/Web/SVG/Tutorial/Paths) (designated as `M`, `L`, and
`C`).  

Usage
------
Below is an example SVG that can be converted to GCode (hypothetically located at
/app/test.svg).  The contents are below:

```
<?xml version="1.0" standalone="yes"?>
<svg width="600" height="500">
<path style="stroke:#020202; stroke-linecap: round; stroke-width:5;fill:none;" d="M524 313C537.472 324.483 557.635 339.142 575 343.649"/>
</svg>
```

If you wanted to convert `test.svg` to GCode, you would run the `perform` method on the
`ConvertSVGStringToGCode` class, passing `test.svg` as a string:

```ruby
#Input
svg_as_string = File.read('/app/test.svg')
ConvertSVGStringToGCode.perform(File.read('/app/test.svg'))

#Output
=> "%\nG21\nG00 Z30.0\nG00 X0.0 Y0.0\nG0 X20.0 Y20.0 Z30.0\nG1 X26.167145600000012 Y25.015007199999996 Z10.0\nG1 X33.13954880000002 Y30.115761599999992 Z10.0\nG1 X40.59837920000004 Y34.85444239999999 Z10.0\nG1 X48.224806400000034 Y38.78322879999999 Z10.0\nG00 X0.0 Y0.0 Z30.0\n%"
```

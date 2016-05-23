class SVGCommand
  attr_accessor :type
  def initialize(**params)
    @type = params[:type]
    @points = params.each_with_object({}) do |(param, value), hsh|
      unless ConversionConstants::VALID_CMD_ATTRIBUTES.include?(param)
        raise TypeError.new('Point label not defined')
      end
      hsh[param] = Float(value) unless value == nil || param == ConversionConstants::TYPE_LABEL
    end
  end

  def method_missing(name)
    super unless ConversionConstants::VALID_CMD_ATTRIBUTES.include? name
    value = @points[name]
    return value
  end

  def adjust_by_proportion(proportion)
    mutated_cp0x = self.cp0x*proportion if self.cp0x
    mutated_cp0y = self.cp0y*proportion if self.cp0y
    mutated_cp1x = self.cp1x*proportion if self.cp1x
    mutated_cp1y = self.cp1y*proportion if self.cp1y
    mutated_p0x  = self.p0x*proportion if self.p0x
    mutated_p0y  = self.p0y*proportion if self.p0y
    mutated_p1x  = self.p1x*proportion if self.p1x
    mutated_p1y  = self.p1y*proportion if self.p1y

    SVGCommand.new(
      type: @type,
      cp0x: mutated_cp0x,
      cp0y: mutated_cp0y,
      cp1x: mutated_cp1x,
      cp1y: mutated_cp1y,
      p0x: mutated_p0x,
      p0y: mutated_p0y,
      p1x: mutated_p1x,
      p1y: mutated_p1y
    )
  end

  def add_margins(x_margin, y_margin)
    mutated_cp0x = self.cp0x+x_margin if self.cp0x
    mutated_cp0y = self.cp0y+y_margin if self.cp0y
    mutated_cp1x = self.cp1x+x_margin if self.cp1x
    mutated_cp1y = self.cp1y+y_margin if self.cp1y
    mutated_p0x  = self.p0x+x_margin if self.p0x
    mutated_p0y  = self.p0y+y_margin if self.p0y
    mutated_p1x  = self.p1x+x_margin if self.p1x
    mutated_p1y  = self.p1y+y_margin if self.p1y

    SVGCommand.new(
      type: @type,
      p0x: mutated_p0x,
      p0y: mutated_p0y,
      p1x: mutated_p1x,
      p1y: mutated_p1y,
      cp0x: mutated_cp0x,
      cp0y: mutated_cp0y,
      cp1x: mutated_cp1x,
      cp1y: mutated_cp1y,
    )
  end
end

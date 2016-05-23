
class ConversionConstants
  MOVE                 = 'M'
  LINE_TO              = 'L'
  CURVE                = 'C'
  X_LABELS             = [:p0x,:p1x,:cp0x,:cp1x,:p0x,:p1x]
  Y_LABELS             = [:p0y,:p1y,:cp0y,:cp1y,:p0y,:p1y]
  TYPE_LABEL           = :type
  VALID_CMD_ATTRIBUTES = X_LABELS + Y_LABELS << TYPE_LABEL
  GCODE_COMMANDS       = 'CLM'
  PROPORTION           = 0.7
  STEP                 = 0.20

  raise TypeError.new('Proportion must be a Float.') if PROPORTION.class != Float
  raise TypeError.new('Step must be a Float.') if STEP.class != Float
end

class Box
  attr_accessor :box_number, :x_min, :x_max, :y_min, :y_max

  def initialize(**params)
    @box_number = params[:box_number]
    @x_min = params[:x_min]
    @x_max = params[:x_max]
    @y_min = params[:y_min]
    @y_max = params[:y_max]
  end

end

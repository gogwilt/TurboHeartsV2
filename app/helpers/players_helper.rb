module PlayersHelper
  def with_dollar_sign(value)
    (value >= 0 ? "" : "-") + "$" + value.abs.to_s
  end
  
  def color_for_dollar_value(point, abs_max)
    dollar_value = point.dollar_value
    green = 255
    red = 255
    blue = 255
    color_value = (255.0 * dollar_value.to_f.abs / abs_max.to_f).to_i
    puts color_value
    if dollar_value > 0
      red -= color_value
      blue -= color_value
    else
      green -= color_value
      blue -= color_value
    end
    "#" + hex_string(red) + hex_string(green) + hex_string(blue)
  end
  
  def absolute_maximum_dollar_value(recent_rounds)
    abs_max = 1 # avoid divide-by-zero errors
    recent_rounds.each do |round|
      round.points.each do |point|
        if abs_max < point.dollar_value.abs
          abs_max = point.dollar_value.abs
        end
      end
    end
    abs_max
  end
  
  private
  
  def hex_string(value)
    value.to_s(16).rjust(2, "0")
  end
end

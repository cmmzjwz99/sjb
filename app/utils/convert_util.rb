class ConvertUtil
  def self.handicap val
    val=val.to_f
    if val%0.5!=0
      return "#{val-0.25}/#{val+0.25}"
    end
    return "#{val}"
  end
end
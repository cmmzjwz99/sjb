class IntegerUtil
  def self.convert(balance)
    return (balance.to_i) if balance%1==0
    return (balance.to_i+1)
  end
end
class SscSettlement
  def self.settlement category,code,content
    case category
      #总单双
      when 1
        self.new.settlement_single_or_double code,content
      #总大小
      when 2
        self.new.settlement_big_or_small code,content,22.5
      #龙虎和
      when 3
        self.new.settlement_first_and_end code,content
      #万单双
      when 4
        self.new.settlement_single_or_double code[0],content
      #万大小
      when 5
        self.new.settlement_big_or_small code[0],content,4.5
      #万数字
      when 6
        self.new.settlement_num code[0],content
      #千单双
      when 7
        self.new.settlement_single_or_double code[1],content
      #千大小
      when 8
        self.new.settlement_big_or_small code[1],content,4.5
      #千数字
      when 9
        self.new.settlement_num code[1],content
      #百单双
      when 10
        self.new.settlement_single_or_double code[2],content
      #百大小
      when 11
        self.new.settlement_big_or_small code[2],content,4.5
      #百数字
      when 12
        self.new.settlement_num code[2],content
      #十单双
      when 13
        self.new.settlement_single_or_double code[3],content
      #十大小
      when 14
        self.new.settlement_big_or_small code[3],content,4.5
      #十数字
      when 15
        self.new.settlement_num code[3],content
      #个单双
      when 16
        self.new.settlement_single_or_double code[4],content
      #个大小
      when 17
        self.new.settlement_big_or_small code[4],content,4.5
      #个数字
      when 18
        self.new.settlement_num code[4],content
      #前3
      when 19
        self.new.settlement_three_num code[0..2],content
      #中3
      when 20
        self.new.settlement_three_num code[1..3],content
      #后3
      when 21
        self.new.settlement_three_num code[2..4],content
    end
  end

  #单双
  def settlement_single_or_double code,content
    num=0
    code.split('').each do |ele|
      num+=ele.to_i
    end
    if num%2==0
      #结果双数
      return(content==2 ? true : false)
    else
      #结果单数
      return(content==1 ? true : false)
    end
  end

  #大小
  def settlement_big_or_small code,content,median
    num=0
    code.split('').each do |ele|
      num+=ele.to_i
    end
    if num > median
      #结果双数
      return(content==1 ? true : false)
    else
      #结果单数
      return(content==2 ? true : false)
    end
  end

  #数字
  def settlement_num code,content
    return(content==code.to_i ? true : false)
  end

  #龙虎和
  def settlement_first_and_end code,content
    if code[0].to_i > code[4].to_i
      return(content==1 ? true : false)
    elsif  code[0].to_i < code[4].to_i
      return(content==2 ? true : false)
    else
      return(content==3 ? true : false)
    end
  end
  
  #前中后
  def settlement_three_num code,content
    if category_1 code
      #豹子
      return(content==1 ? true : false)
    elsif category_2 code
      #顺子
      return(content==2 ? true : false)
    elsif category_3 code
      #对子
      return(content==3 ? true : false)
    elsif category_4 code
      #半顺
      return(content==4 ? true : false)
    else
      #其他
      return(content==5 ? true : false)
    end
    
  end

  #是否豹子
  def category_1 code
    num=code.split('')
    if num[0]==num[1] && num[1]==num[2]
      return true
    else
      return false
    end
  end

  #是否顺子
  def category_2 code
    num=code.split('')
    num.sort!
    if (num[1].to_i-num[0].to_i)==1
      if (num[2].to_i-num[1].to_i)==1 || (num[0].to_i+10-num[2].to_i)==1
        return true
      end
    elsif (num[2].to_i-num[1].to_i)==1
      if (num[1].to_i-num[0].to_i)==1 || (num[0].to_i+10-num[2].to_i)==1
        return true
      end
    end
    return false
  end

  #是否对子
  def category_3 code
    num=code.split('')
    if num[0]==num[1] || num[1]==num[2] || num[0]==num[2]
      return true
    else
      return false
    end
  end

  #是否半顺
  def category_4 code
    num=code.split('')
    num.sort!
    if (num[1].to_i-num[0].to_i)==1 || (num[2].to_i-num[1].to_i)==1 || (num[0].to_i+10-num[2].to_i)==1
      return

    end
    return false
  end
end
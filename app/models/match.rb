class Match < ActiveRecord::Base
  self.table_name='matchs'
  has_many :games
  #status 0未开始 1可竞猜 2进行中 3已结束

  TEAM=['俄罗斯','沙特阿拉伯','埃及','乌拉圭', '葡萄牙','西班牙','摩洛哥','伊朗',
        '法国','澳大利亚','秘鲁','丹麦', '阿根廷','冰岛','克罗地亚','尼日利亚',
        '巴西','瑞士','哥斯达黎加','塞尔维亚', '德国','墨西哥','瑞典','韩国',
        '比利时','巴拿马','突尼斯','英格兰', '波兰','塞内加尔','哥伦比亚','日本']

  def get_match_id
    doc = Nokogiri::HTML(open('http://interface.win007.com/zq/BF_XML.aspx?'))
    doc = doc.css('list match')

    doc.each do |match|
      if match.css('h').text =~/#{self.team1}/ &&  match.css('i').text=~/#{self.team2}/
        self.match_id=match.css('a').text
      end
    end
    self.save
  end


  def get_odds
    doc = Nokogiri::HTML(open('http://interface.win007.com/zq/odds.aspx'))
    main=doc.text.split('$')

    #让球
    arr1=main[2].split(';')
    #标准盘
    arr2=main[3].split(';')
    #大小球
    arr3=main[4].split(';')
    #半场让球
    arr4=main[6].split(';')
    #半场大小球
    arr5=main[7].split(';')

    res=[]

    arr1.each do |ele|
      ele=ele.split(',')
      if ele[0]==self.match_id && ele[1]=='8'
        res[0]=[ele[6],ele[7]]
      end
    end

    arr2.each do |ele|
      ele=ele.split(',')
      if ele[0]==self.match_id && ele[1]=='8'
        res[1]=[ele[5],ele[6],ele[7]]
      end
    end

    arr3.each do |ele|
      ele=ele.split(',')
      if ele[0]==self.match_id && ele[1]=='8'
        res[2]=[ele[6],ele[7]]
      end
    end

    arr4.each do |ele|
      ele=ele.split(',')
      if ele[0]==self.match_id && ele[1]=='8'
        res[3]=[ele[6],ele[7]]
      end
    end

    arr5.each do |ele|
      ele=ele.split(',')
      if ele[0]==self.match_id && ele[1]=='8'
        res[4]=[ele[6],ele[7]]
      end
    end

    return res
  end
end
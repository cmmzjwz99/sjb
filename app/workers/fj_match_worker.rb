class FjMatchWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence  { daily.hour_of_day(7).minute_of_hour(31) }

  def perform
    (0..2).each do |i|
      get_data (Time.now+i.days).strftime('%Y-%m-%d')
    end
  end

  def get_data date
    doc = Nokogiri::HTML(open("http://interface.win007.com/zq/BF_XML.aspx?date=#{date}"))
    doc = doc.css('list match')

    doc.each do |match|
      fjmatch=FjMatch.find_by_match_id(match.css('a').text) || FjMatch.new

      fjmatch.name="#{match.css('c').text.split(',').first} #{match.css('s').text}"
      fjmatch.team1=match.css('h').text.split(',').first
      fjmatch.team2=match.css('i').text.split(',').first
      fjmatch.match_id=match.css('a').text
      fjmatch.time=match.css('d').text
      fjmatch.save
    end

    FjMatch.where(time:['2018-01-01'..(Time.now-2.days).strftime('%Y-%m-%d')]).destroy_all
  end
end
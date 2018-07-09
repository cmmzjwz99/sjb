json.code @sscs.nil? ? 1 : 0
json.data(@sscs) do |ssc|
  json.extract! ssc, :code,:issue
  json.day ssc.time.strftime('%Y-%m-%d')
  json.time ssc.time.strftime('%H:%M:%S')
end
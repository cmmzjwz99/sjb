json.code 0
json.data do
  json.url @url
  json.week_journal @journal.journal
  json.week_income @journal.income
  json.has_rebate @journal.rebate
  rebate=@journal_log.sum('income')
  json.rebate rebate
  json.can_rebate rebate-@journal.rebate
  json.journal_log(@journal_log) do |ele|
    json.extract! ele, :time, :journal, :income
  end
end

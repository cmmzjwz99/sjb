json.code @bank.nil? ? 1 : 0
json.data do
  json.extract! @bank, :no, :name,:bank
end

json.code @payment.nil? ? 1 : 0
json.data do
  json.extract! @payment, :id, :balance,:no
  user=current_user.father_id.present? ? User.find(current_user.father_id) : User.find(1)
  payment=user.user_payment || UserPayment.new({alipay_status: false, wechat_status: false, bank_status: false})
  json.bank_no payment.bank_no || ''
  json.bank_user payment.bank_user || ''
end

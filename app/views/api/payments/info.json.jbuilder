json.code @payment.nil? ? 1 : 0
json.data do
  json.extract! @payment, :id, :balance,:no,:category
  user=current_user.father_id.present? ? User.find(current_user.father_id) : User.find(1)
  payment=user.user_payment || UserPayment.new({alipay_status: false, wechat_status: false, bank_status: false})
  json.bank_no payment.bank_no || ''
  json.bank_user payment.bank_user || ''
  json.bank_name payment.bank_name || ''
  json.bank_address payment.bank_address || ''
  case @payment.status
    when 1
      json.status '审核通过'
    when 2
      json.status "审核失败 #{@payment.remark}"
    when 3
      json.status "已撤销"
    when 0
      json.status '审核中'
  end
end

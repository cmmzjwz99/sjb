json.code @payment.nil? ? 1 : 0
json.data do
  json.extract! @payment, :alipay_status, :wechat_status, :bank_status
  if @payment.alipay_status==true
    json.extract! @payment,:alipay_name
    json.alipay_url (@payment.alipay_qr.nil? ? '' : @payment.alipay_qr.url)
  end
  if @payment.wechat_status==true
    json.extract! @payment,:wechat_name
    json.wechat_url (@payment.wechat_qr.nil? ? '' : @payment.wechat_qr.url)
  end
  if @payment.bank_status==true
    json.extract! @payment,:bank_no,:bank_name,:bank_user
  end
end

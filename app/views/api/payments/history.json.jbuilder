json.code 0
json.data do
  json.cz(Payment.where(user: current_user, payment_type: true)) do |payment|
    json.extract! payment, :balance, :id
    json.date payment.created_at.strftime('%Y-%m-%d')
    json.time payment.created_at.strftime('%H:%M:%S')
    if payment.status==0
      json.status '审核中'
    elsif payment.status==1
      json.status '审核成功'
    else
      json.status '审核失败'
    end
  end
  json.tx(Payment.where(user: current_user, payment_type: false)) do |payment|
    json.extract! payment, :balance, :id
    json.date payment.created_at.strftime('%Y-%m-%d')
    json.time payment.created_at.strftime('%H:%M:%S')
    if payment.status==0
      json.status '审核中'
    elsif payment.status==1
      json.status '审核成功'
    else
      json.status '审核失败'
    end
  end
end

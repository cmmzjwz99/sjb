json.code 0
json.data do
  json.cz(Payment.where(user: current_user, payment_type: true).order(created_at: :desc)) do |payment|
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
  json.tx(Payment.where(user: current_user, payment_type: false).order(created_at: :desc)) do |payment|
    json.extract! payment, :balance, :id
    json.date payment.created_at.strftime('%Y-%m-%d')
    json.time payment.created_at.strftime('%H:%M:%S')
    if payment.status==0
      json.status '审核中'
    elsif payment.status==1
      json.status '审核成功'
    elsif payment.status==3
      json.status '已撤销'
    else
      json.status '审核失败'
    end
  end
end

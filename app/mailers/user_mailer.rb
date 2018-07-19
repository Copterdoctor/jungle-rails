class UserMailer < ApplicationMailer

  def order_email(order, items)
    @order = order
    @items = items
    @url  = 'http://example.com/login'
    mail(to: "janders.ame@gmail.com", subject: 'Your Jungle receipt')
  end

end

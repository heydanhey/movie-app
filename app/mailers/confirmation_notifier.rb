class ConfirmationNotifier < ApplicationMailer
  default :from => 'confirmation@movie-app.com'

  def successful_order(order)
    @order = order
    mail(
      to: @order.email,
      subject: 'ORDER CONFIRMATION'
    )
  end
end
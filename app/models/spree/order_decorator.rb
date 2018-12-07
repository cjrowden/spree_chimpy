Spree::Order.class_eval do
  has_one :source, class_name: 'Spree::Chimpy::OrderSource'

  around_save :handle_cancelation
  after_save :notify_mail_chimp

  def notify_mail_chimp
    # If this Order is complete, send an Order to MailChimp & Remove any existing Carts
    Spree::Chimpy.enqueue(:order, self) if self.completed? && Spree::Chimpy.configured?

    # Sync the Cart entry in MailChimp (THis will remove the cart if the Order is completed)
    Spree::Chimpy.enqueue(:cart, self) if Spree::Chimpy.configured?
  end

private
  def handle_cancelation
    canceled = state_changed? && canceled?
    yield
    notify_mail_chimp if canceled
  end
end

Spree::LineItem.class_eval do

  after_save :notify_mail_chimp

  def notify_mail_chimp
    self.order.notify_mail_chimp unless self.order.nil?
  end

end

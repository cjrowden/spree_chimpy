if Spree.user_class
  Spree.user_class.class_eval do

    after_create  :subscribe
    after_destroy :unsubscribe
    after_initialize :assign_subscription_default

    delegate :subscribe, :resubscribe, :unsubscribe, to: :subscription

    def notify_mail_chimp(options = {})
      # If a user has been successfully created, create a new user on MailChimp.
      Spree::Chimpy.enqueue(:subscribe, self, options) if Spree::Chimpy.configured?
    end

  private
    def subscription
      Spree::Chimpy::Subscription.new(self)
    end

    def assign_subscription_default
      self.subscribed ||= Spree::Chimpy::Config.subscribed_by_default if new_record?
    end
  end
end

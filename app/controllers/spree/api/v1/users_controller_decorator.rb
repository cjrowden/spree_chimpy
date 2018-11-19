Spree::Api::V1::UsersController.class_eval do
  def sync_with_mail_chimp(options = {})
    unless(@user.nil?)
      @user.notify_mail_chimp(options)
    end
  end
end

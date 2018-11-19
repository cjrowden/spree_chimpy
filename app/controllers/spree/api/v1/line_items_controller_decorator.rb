Spree::Api::V1::LineItemsController.class_eval do

  after_action :sync_with_mail_chimp, except: [:item_history, :index]

  def sync_with_mail_chimp
    unless(@line_item.order.nil?)
      @line_item.order.notify_mail_chimp
    end
  end
end

class AddSmsNotificationSendedToAnswers < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :sms_notification_sended, :boolean, default: false
  end
end

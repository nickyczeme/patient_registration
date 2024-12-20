class SmsNotificationService
  def self.send_sms(phone, message)
    Rails.logger.info("SMS to #{phone}: #{message}")
  end
end

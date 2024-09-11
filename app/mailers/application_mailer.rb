class ApplicationMailer < ActionMailer::Base
  default from: email_address_with_name("noreply@#{SellRepo.smtp_domain}", SellRepo.store_name)
  layout "mailer"
end

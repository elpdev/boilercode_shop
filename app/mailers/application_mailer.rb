class ApplicationMailer < ActionMailer::Base
  default from: "noreply@#{SellRepo.smtp_domain}"
  layout "mailer"
end

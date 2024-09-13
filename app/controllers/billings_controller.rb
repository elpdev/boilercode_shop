class BillingsController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def edit
    case SellRepo.payment_processor
    when :stripe
      stripe
    when :lemon_squeezy
      lemon_squeezy
    else
      redirect_to billing_path, alert: "Payments are not enabled."
    end
  end

  private

  def stripe
    portal = current_user.payment_processor.billing_portal(return_url: root_url)
    redirect_to portal.url, allow_other_host: true
  end

  def lemon_squeezy
    if (url = current_user.payment_processor.portal_url)
      redirect_to current_user.payment_processor.portal_url, allow_other_host: true
    else
      redirect_to root_path, alert: "Billing is only accessible when you have an active subscription."
    end
  end
end

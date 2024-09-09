class Checkout::ReturnsController < ApplicationController
  before_action :authenticate_user!
  before_action :sync_params
  before_action :handle_free_licenses, if: -> { @charge_or_subscription.nil? }

  def show
    redirect_to @charge_or_subscription&.license || licenses_path
  end

  private

  def sync_params
    @charge_or_subscription = Pay.sync(params)
  end

  def handle_free_licenses
    return if @charge_or_subscription.present?

    if (checkout_session_id = params[:stripe_checkout_session_id]) &&
        (cs = ::Stripe::Checkout::Session.retrieve(checkout_session_id)) &&
        cs.status == "complete" &&
        cs.amount_total == 0 &&
        cs.metadata["user_id"] == current_user.id.to_s &&
        (product = Product.find_by(cs.metadata["product_id"]))

      license = current_user.licenses.create!(
        product: product,
        name: "#{product.name} License",
        state: :active,
        allowed_users: product.allowed_users
      )

      redirect_to license
    end
  end
end

module Product::Payments
  extend ActiveSupport::Concern

  included do
    scope :one_time, -> { where(interval_count: nil) }
    scope :recurring, -> { where.not(interval_count: nil) }

    validates :stripe_price_id, format: { allow_blank: true, with: /\Aprice_.+\z/ }

    before_validation :sync_stripe_price, if: :stripe_price_id_changed?
    before_validation :sync_lemon_squeezy_price, if: :lemon_squeezy_variant_id_changed?
  end

  def sync_stripe_price
    if stripe_price_id?
      price = ::Stripe::Price.retrieve(stripe_price_id)
      assign_attributes(
        amount_in_cents: price.unit_amount,
        interval: price.recurring&.interval,
        interval_count: price.recurring&.interval_count,
      )
    elsif stripe_price_id_was.present?
      assign_attributes(amount_in_cents: nil, interval: nil, interval_count: nil)
    end
  rescue ::Stripe::StripeError => e
    errors.add :stripe_price_id, e.message
  end

  def sync_lemon_squeezy_price
    if lemon_squeezy_variant_id?
      price = ::LemonSqueezy::Price.list(variant_id: lemon_squeezy_variant_id).data.first

      assign_attributes(
        amount_in_cents: price.unit_price,
        interval: (price.category == "subscription" ? price.renewal_interval_unit: nil),
        interval_count: (price.category == "subscription" ? price.renewal_interval_quantity: nil),
      )
    elsif lemon_squeezy_variant_id_was.present?
      assign_attributes(amount_in_cents: nil, interval: nil, interval_count: nil)
    end
  rescue ::LemonSqueezy::Error => e
    errors.add :lemon_squeezy_, e.message
  end
end

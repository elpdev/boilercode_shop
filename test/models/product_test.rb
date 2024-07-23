require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "create product" do
    assert_nothing_raised do
      stub_request(:get, "https://api.stripe.com/v1/prices/price_12345").to_return(body: '{ "id": "price_12345", "object": "price", "active": true, "billing_scheme": "per_unit", "created": 1679431181, "currency": "usd", "custom_unit_amount": null, "livemode": false, "lookup_key": null, "metadata": {}, "nickname": null, "product": "prod_NZKdYqrwEYx6iK", "recurring": { "aggregate_usage": null, "interval": "month", "interval_count": 1, "trial_period_days": null, "usage_type": "licensed" }, "tax_behavior": "unspecified", "tiers_mode": null, "transform_quantity": null, "type": "recurring", "unit_amount": 1000, "unit_amount_decimal": "1000" }')
      stub_request(:get, "https://api.github.com/repos/example/repo")

      product = Product.create!(
        name: "Example",
        stripe_price_id: "price_12345",
        github_repo: "https://github.com/example/repo"
      )

      assert_equal 10_00, product.amount_in_cents
    end
  end
end

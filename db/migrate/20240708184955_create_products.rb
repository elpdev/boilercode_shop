class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :slug, null: false, index: { unique: true }
      t.string :featured_image_url
      t.string :short_description
      t.text :description
      t.string :github_repo
      t.integer :amount_in_cents
      t.string :stripe_price_id
      t.string :lemon_squeezy_variant_id
      t.string :interval
      t.integer :interval_count
      t.integer :allowed_users, default: 1
      t.boolean :hidden, default: false, index: true

      t.timestamps
    end
  end
end

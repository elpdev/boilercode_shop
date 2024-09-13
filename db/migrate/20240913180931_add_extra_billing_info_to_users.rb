class AddExtraBillingInfoToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :extra_billing_info, :text
  end
end

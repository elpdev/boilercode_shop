class CreateConfigs < ActiveRecord::Migration[7.2]
  def change
    create_table :configs do |t|
      t.string :store_name
      t.string :company_name
      t.string :description
      t.string :support_url
      t.string :logo_url
      t.string :opengraph_image_url

      t.timestamps
    end
  end
end

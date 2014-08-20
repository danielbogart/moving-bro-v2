class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :category_name
      t.string :item_name
      t.string :item_description
      t.string :amazon_affiliate_link
      t.decimal :price
      t.string :user

      t.timestamps
    end
  end
end

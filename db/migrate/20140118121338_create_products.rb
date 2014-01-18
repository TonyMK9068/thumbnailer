class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, :null => false
      t.string :price
      t.string :store
      t.string :link
      t.string :product_number, :null => false
      t.string :category
      t.string :image_url
      t.timestamps
    end
  end
end

class Product < ActiveRecord::Base
  attr_accessible :category, :image_url, :link, :name, :price, :product_number, :store
end

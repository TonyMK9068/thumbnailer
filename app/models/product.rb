class Product < ActiveRecord::Base
  attr_accessible :category, :image_url, :link, :name, :price, :product_number, :store

  def self.product_keys
    %w(id link category title).map(&:to_sym)
  end

  def self.featured(keyword, category)
    category = category.split(' ').collect(&:capitalize).join # amazon api requires camelcase 
    products = Amazon::Ecs.item_search(keyword, search_index: category).items.collect do |item|
      info_array = [ item.get('ASIN'), item.get('DetailPageURL'), item.get('ItemAttributes/ProductGroup'), item.get('ItemAttributes/Title') ]
      Hash[product_keys.zip info_array]
    end
  end
  
  def self.show_item(asin)
    item = Amazon::Ecs.item_lookup(asin).items.collect do |item|
      info_array = [ item.get('ASIN'), item.get('DetailPageURL'), item.get('ItemAttributes/ProductGroup'), item.get('ItemAttributes/Title') ]
      Hash[product_keys.zip info_array]
    end
  end    
end

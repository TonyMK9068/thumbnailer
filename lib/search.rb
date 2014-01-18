class Search < ActiveRecord::Base

  attr_accessible :keyword, :page
  
  validates_format_of :keyword, with: /\A[a-zA-Z]([^;~@^*]*+)\z/i
  validates_length_of :keyword, maximum: 100
  validates :page, numericality: true

  def amazon_response
    HTTParty.get(AmazonRequest.new.item_search(self.keyword, self.page))
  end

  def etsy_response
    HTTParty.get(EtsyRequest.new.search(self.keyword, self.page))
  end

  def product_keys
    %w(product_number image_url price name link category store).map! { |value| value.to_sym }
  end
  
  def amazon_array_of_arrays
    response = amazon_response.access("ItemSearchResponse.Items.Item").collect do |re|
        [
          re.access("ASIN"),
          re.access("LargeImage.URL") || re.access("MediumImage.URL") || re.access("SmallImage.URL") || '/568.png',
          re.access("ItemAttributes.ListPrice.FormattedPrice"),
          re.access("ItemAttributes.Title"),
          re.access("DetailPageURL"),
          re.access("ItemAttributes.ProductGroup"),
          "Amazon.com"
        ]
      end
    response = response.collect do |array|      
      array.delete_if do |x|
       x == '' || x == nil
      end
    end
    response
  end
  
  def etsy_array_of_arrays
    if self.etsy_count > 0
      response = etsy_response.access("results").collect do |re|
        [
          re.access("listing_id"),
          re.access("Images.0.url_570xN") || re.access("Images.0.url_170x135"),
          re.access("price"), 
          re.access("title"),
          re.access("url"),
          re.access("category_path").last,
          "Etsy.com"
          ]
      end
    else
      false
    end
  end

  def amazon_response_arrays
    if amazon_array_of_arrays
      amazon_array_of_arrays.collect do |array|
        Hash[product_keys.zip array]
      end
    end
  end

  def etsy_response_arrays
    if etsy_array_of_arrays
      etsy_array_of_arrays.collect do |array|
        Hash[product_keys.zip array]
      end
    end
  end
  
  def combined_results
     results = [etsy_response_arrays, amazon_response_arrays]
     results.delete_if { |x| x.blank? }
     count = results.length
     if count > 0
       results = results.inject{ |sum, x| sum + x }
     else
       false
     end
  end

  def etsy_count
    etsy_response.access("count")
  end
  
  def amazon_count
    amazon_response.access("ItemSearchResponse.Items.Request.TotalResults")
  end
  
  protected 

  def ownership_of_list
    errors.add(:list_id, "Not authorized to perform searches for this list") if user.lists.include? List.find(list_id) == false
  end
end
class Search::EtsyRequest
  def search(keyword, page = 1)
    page_offset = (page * 12) - 12
    encoded_keyword = URI.encode_www_form_component keyword
    request_url = "https://openapi.etsy.com/v2/listings/active?includes=Images&limit=12&offset=#{page_offset}&keywords=#{encoded_keyword}&sort_on=created&sort_order=down&api_key=#{ENV['ETSY_KEY']}"
  end
end
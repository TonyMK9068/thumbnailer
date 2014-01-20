Product.featured('wide screen', 'electronics').first(20).each do |p|
  p = Product.new(product_number: p[:id], name: p[:title], link: p[:link], category: p[:category], store: 'Amazon')
  p.save!
end

p 'Products saved'
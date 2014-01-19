Amazon::Ecs.configure do |options|
  options[:associate_tag] = ENV["AMAZON_ASSOCIATE"]
  options[:AWS_access_key_id] = ENV["AMAZON_KEY"]
  options[:AWS_secret_key] = ENV["AMAZON_SECRET"]
end
desc "Fetch Amazon listings from orders"
task :fetch_amazon_listings => :environment do
  puts "Fetching Amazon listings"
  FetchAmazonListingsWorker.new.perform
  puts "done."
end
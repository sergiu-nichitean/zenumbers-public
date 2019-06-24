desc "Fetch Amazon orders items"
task :fetch_amazon_order_items => :environment do
  puts "Fetching Amazon order items"
  FetchAmazonOrderItemsWorker.new.perform
  puts "done."
end
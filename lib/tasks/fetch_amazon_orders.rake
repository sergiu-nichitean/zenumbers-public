desc "Fetch Amazon orders"
task :fetch_amazon_orders => :environment do
  puts "Fetching Amazon orders"
  FetchAmazonOrdersWorker.new.perform
  puts "done."
end
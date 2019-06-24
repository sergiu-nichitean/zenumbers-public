desc "Fetch Amazon financial events"
task :fetch_amazon_financial_events => :environment do
  puts "Fetching Amazon financial events"
  FetchAmazonFinancialEventsWorker.new.perform
  puts "done."
end
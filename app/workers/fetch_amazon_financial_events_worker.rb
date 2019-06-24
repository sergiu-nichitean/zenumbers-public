class FetchAmazonFinancialEventsWorker
  
  def perform
    AmazonFinancialEvent.fetch_from_amazon
  end

end
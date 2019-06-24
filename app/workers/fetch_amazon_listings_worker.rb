class FetchAmazonListingsWorker
  
  def perform
    AmazonListing.fetch_from_orders
  end

end
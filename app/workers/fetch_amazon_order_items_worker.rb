class FetchAmazonOrderItemsWorker
	include Sidekiq::Worker

  def perform(delay = 0)
    AmazonOrderItem.fetch_from_amazon(delay)
  end
end
class FetchAmazonOrdersWorker
	include Sidekiq::Worker

  def perform(delay = 0)
    AmazonOrder.fetch_from_amazon(delay)
  end
end
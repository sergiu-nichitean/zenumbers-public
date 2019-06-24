class CreateExpensesWorker
  
  def perform
    Expense.fetch_from_listings
  end

end
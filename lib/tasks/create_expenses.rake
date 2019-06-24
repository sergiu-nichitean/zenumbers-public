desc "Create expenses from Amazon listings"
task :create_expenses => :environment do
  puts "Creating expenses"
  CreateExpensesWorker.new.perform
  puts "done."
end
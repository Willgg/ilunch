namespace :orders do
  desc "Populate automaticcaly invoice_id column of orders table"
  task add_invoice_id: :environment do
    i = 1
    errors = []

    Order.done.order(created_at: :asc).each do |order|
      order.invoice_id = i
      if order.save
        i += 1
        puts order.inspect
      else
        errors << order.id
      end
    end

    puts 'Column invoice_id of Order has been populated'
    puts 'Errors:'
    if errors.length <= 0
      puts '- Aucune -'
    else
      puts errors
    end
  end
end

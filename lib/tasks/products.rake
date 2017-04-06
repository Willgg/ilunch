namespace :products do
  desc "Duplicate all the products for another day"
  task duplication: :environment do
    week = []
    date = Date.tomorrow
    until week.count == 5 do
      week << date if ( date.wday != 6 && date.wday != 0 )
      date += 1.day
    end

    Product.all.each do |product|
      attributes = product.attributes.except!('created_at', 'updated_at', 'id')
      new_product = Product.new(attributes)
      new_product.date = week.first
      new_product.valid?
      puts
      if new_product.save
        puts "Product##{product.id} has been created"
      else
        @result = 0
        puts "Product##{product.id} has not been duplicated ! \n #{new_product.errors.messages.inspect}"
      end
    end

    puts '#################################'
    if @result == 0
      puts 'One product duplication has failed.'
    else
      puts 'Products duplication successfully done.'
    end

  end

end

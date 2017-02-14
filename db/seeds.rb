# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

Product.destroy_all
User.destroy_all
Order.destroy_all
Company.destroy_all

url = 'https://cdn.shopify.com/s/files/1/0832/9391/products/unnamed-1.jpg?v=1484325256'
product_1 = Product.create( name: 'Rigatoni alla romesco', price_cents: [500, 600, 700, 800, 900, 1000].sample,
              description: 'De grosses pâtes creuses avec une sauce tomates, ' \
              'poivrons, paprika et amandes, pour un goût subtilement fumé. ')
product_1.photo_url = url

url = 'https://cdn.shopify.com/s/files/1/0832/9391/products/salade_de_boulghour_carottes_roties.jpg?v=1486029431'
product_2 = Product.create( name: 'Salade de boulgour, carottes rôties aux épices et fêta',
              price_cents: [500, 600, 700, 800, 900, 1000].sample,
              description: 'Un effiloché de porc aux accents exotiques,' \
              'fondant à souhait, avec de gros morceaux d\'ananas juteux et une' \
              'sauce soja qui font honneur à cette référence du sucré-salé.' )
product_2.photo_url = url

url = 'https://cdn.shopify.com/s/files/1/0832/9391/products/saumon_et_semoule_a_l_orange.jpg?v=1484325437'
product_3 = Product.create( name: 'Saumon mi-cuit et semoule aux épices',
              price_cents: [500, 600, 700, 800, 900, 1000].sample,
              description: 'Un pavé de saumon juste cuit avec une crème à ' \
              'l\'orange doucement sucrée sur un lit de semoule aux épices,' \
              ' parsemé de coriandre fraîche.' )
product_3.photo_url = url


19.times do
  Company.create( name: Faker::Company.name, street: Faker::Address.street_address,
                  post_code: Faker::Address.zip_code, delivery_time: Company::TIMESLOT.sample )
end

49.times do
  user = User.create( first_name: Faker::Name.first_name, last_name: Faker::Name.last_name,
               email: Faker::Internet.email, password: Faker::Internet.password(8),
               optin: [true, false].sample, admin: false )
  order = Order.create( user: user, company: Company.all.sample )
  product = Product.all.sample
  quantity = [1,2,3].sample
  LineItem.create(order: order, quantity: quantity, product: product,
                  price_cents: product.price_cents * quantity )
end

user_1 = User.create( first_name: 'William', last_name: 'Grenier Godard',
                      email: 'grenier.godard@gmail.com', password: 'billyboy',
                      optin: true, admin: true )

user_2 = User.create( first_name: 'Victoria', last_name: 'Benhaim',
                      email: 'victoria.startup@gmail.com', password: 'ilunch',
                      optin: true, admin: true )

company_1 = Company.create( name: 'Le Village', street: '55 rue de la boétie',
                            post_code: '75008', delivery_time: Company::TIMESLOT.sample )

order_1 = Order.create( user: user_1, company: company_1 )

LineItem.create(order: order_1, quantity: 1, product: product_1, price_cents: product_1.price_cents)
LineItem.create(order: order_1, quantity: 2, product: product_2, price_cents: product_2.price_cents * 2)

puts "Database has been populated with the seed !"

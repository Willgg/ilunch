# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

MenuItem.destroy_all
Product.destroy_all
User.destroy_all
Order.destroy_all
Company.destroy_all
Menu.destroy_all

url = "https://thumb1.shutterstock.com/display_pic_with_logo/754414/309940103/stock-photo-a-illustration-of-hong-kong-style-food-set-teatime-cold-milk-tea-cold-lemon-tea-egg-with-309940103.jpg"
menu_1 = Menu.create(title: 'Plat + boisson + dessert', main: 1, dessert: 1, drink: 1, price_cents: 650)
menu_1.photo_url = url

url = "http://st3.depositphotos.com/3213441/13066/v/450/depositphotos_130662144-stock-illustration-carrot-and-apple-juice-in.jpg"
menu_2 = Menu.create(title: 'Plat + boisson', main: 1, dessert: 0, drink: 1, price_cents: 550)
menu_2.photo_url = url

url = 'https://cdn.shopify.com/s/files/1/0832/9391/products/unnamed-1.jpg?v=1484325256'
product_1 = Product.create( name: 'Rigatoni alla romesco', price_cents: [500, 600, 700, 800, 900, 1000].sample,
              description: 'De grosses pâtes creuses avec une sauce tomates, ' \
              'poivrons, paprika et amandes, pour un goût subtilement fumé.',
              date: Date.today, stock: 100, category: 'main')
product_1.photo_url = url

url = 'https://cdn.shopify.com/s/files/1/0832/9391/products/salade_de_boulghour_carottes_roties.jpg?v=1486029431'
product_2 = Product.create( name: 'Salade de boulgour, carottes rôties aux épices et fêta',
              price_cents: [500, 600, 700, 800, 900, 1000].sample,
              description: 'Un effiloché de porc aux accents exotiques,' \
              'fondant à souhait, avec de gros morceaux d\'ananas juteux et une' \
              'sauce soja qui font honneur à cette référence du sucré-salé.',
              date: Date.today, stock: 100, category: 'main' )
product_2.photo_url = url

url = 'https://cdn.shopify.com/s/files/1/0832/9391/products/saumon_et_semoule_a_l_orange.jpg?v=1484325437'
product_3 = Product.create( name: 'Saumon mi-cuit et semoule aux épices',
              price_cents: [500, 600, 700, 800, 900, 1000].sample,
              description: 'Un pavé de saumon juste cuit avec une crème à ' \
              'l\'orange doucement sucrée sur un lit de semoule aux épices,' \
              ' parsemé de coriandre fraîche.', date: Date.today + 1.day, stock: 100,
              category: 'main' )
product_3.photo_url = url

url = 'https://static.frichti.co/frichti/image/fetch/w_1310,h_880,c_fit/https://cdn.shopify.com/s/files/1/0832/9391/products/chou-rouge-a-la-japonaise.jpg?v=1484325243'
product_4 = Product.create( name: 'Chou rouge à la japonaise',
              price_cents: [390].sample,
              description: 'Une salade de chou rouge, comme au restaurant japonais !',
              date: Date.today, stock: 100, category: 'main' )
product_4.photo_url = url

url = 'https://static.frichti.co/frichti/image/fetch/w_1310,h_880,c_fit/https://cdn.shopify.com/s/files/1/0832/9391/products/salade_fraicheur_aux_citrons_confits.jpg?v=1486580814'
product_5 = Product.create( name: 'Salade fraicheur aux citrons confits',
              price_cents: [330].sample,
              description: 'Une salade aux champignons pleine de fraîcheur, avec ses citrons confits et sa feta.',
              date: Date.today + 1.day, stock: 100, category: 'main' )
product_5.photo_url = url

url = 'https://cdn.shopify.com/s/files/1/0832/9391/products/cookie-1.jpg?v=1484325222'
product_6 = Product.create( name: 'Crazy Cookie',
              price_cents: [330].sample,
              description: 'Un gros cookie aux pépites de chocolat, bien croquant sur les bords et moelleux au centre.',
              date: Date.today + 1.day, stock: 100, category: 'dessert' )
product_6.photo_url = url

url = 'http://www.ecotraiteur.fr/jus-d-orange-ultra-frais-ig-39.jpg'
product_7 = Product.create( name: 'Jus d\'orange pressée',
              price_cents: [330].sample,
              description: 'Jus frais d\'oranges d\'Avignon labelisées bio',
              date: Date.today + 1.day, stock: 100, category: 'drink' )
product_7.photo_url = url


9.times do
  Company.create( name: Faker::Company.name, street: Faker::Address.street_address,
                  post_code: Faker::Address.zip_code, delivery_time: Company::TIMESLOT.sample )
end

29.times do
  user = User.create( first_name: Faker::Name.first_name, last_name: Faker::Name.last_name,
               email: Faker::Internet.email, password: Faker::Internet.password(8),
               optin: [true, false].sample, admin: false, company: Company.all.sample,
               street: Faker::Address.street_address, post_code: '75000',
               city: 'Paris' )
  order = Order.create( user: user, status: payed )
  li = LineItem.new(order: order, quantity: 1, menu: menu_1,
                    price_cents: menu_1.price_cents )
  li.save
  MenuItem.create(product: Product.category('main').sample, line_item: li, quantity: 1)
  MenuItem.create(product: Product.category('dessert').sample, line_item: li, quantity: 1)
  MenuItem.create(product: Product.category('drink').sample, line_item: li, quantity: 1)
end

company_1 = Company.create( name: 'Le Village', street: '55 rue de la boétie',
                            post_code: '75008', delivery_time: Company::TIMESLOT.sample )

user_1 = User.create( first_name: 'William', last_name: 'Grenier Godard',
                      email: 'grenier.godard@gmail.com', password: 'billyboy',
                      optin: true, admin: true, company: company_1,
                      street: '19 rue Collange', post_code: '92300',
                      city: 'Levallois-Perret' )

user_2 = User.create( first_name: 'Victoria', last_name: 'Benhaim',
                      email: 'victoria.startup@gmail.com', password: 'ilunch',
                      optin: true, admin: true, company: company_1,
                      street: '55 rue de la Boétie', post_code: '75008',
                      city: 'Paris'  )

order_1 = Order.create( user: user_1 )

LineItem.create(order: order_1, quantity: 1, menu: menu_1, price_cents: product_1.price_cents)

puts "Database has been populated with the seed !"

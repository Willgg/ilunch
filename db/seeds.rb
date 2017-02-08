# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.destroy_all
User.destroy_all
Company.destroy_all
product_1 = Product.create( photo: nil, name: 'Salade de crevette au garam massala',
               description: 'Une salade exotique très parfumée au garam masala,'\
               'un mélange d\'épices indien, avec des crevettes, des carottes' \
               ' et de la coriandre fraîche')
product_2 = Product.create( photo: nil, name: 'Pineapple pork pot',
               description: 'Un effiloché de porc aux accents exotiques,' \
              'fondant à souhait, avec de gros morceaux d\'ananas juteux et une' \
              'sauce soja qui font honneur à cette référence du sucré-salé.' )

user_1 = User.create( email: 'grenier.godard@gmail.com', password: 'billyboy' )

company_1 = Company.create( name: 'Le Village', street: '55 rue de la boétie',
                            post_code: '75008', delivery_time: Company::TIMESLOT.sample )

order_1 = Order.create( user: user_1, company: company_1 )

LineItem.create(order: order_1, quantity: 1, product: product_1)
LineItem.create(order: order_1, quantity: 1, product: product_2)

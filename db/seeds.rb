# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

  #default admin
  User.create(username: 'admin', email: 'admin@admin.com', password:
              'admin', password_confirmation: 'admin')

  hrvoje = Consumer.create(name: 'hrvoje')

  mail = DeliveryService.create(name: 'mail')
  phone = DeliveryService.create(name: 'phone')

  DeliveryServiceProperty.create(key: 'smtp',
                                 value: 'smtp.t-com.hr',
                                 delivery_service_id: mail.id)

  DeliveryAddress.create(name: 'telefon doma',
                         address: '013869246',
                         delivery_service_id: phone.id,
                         consumer_id: hrvoje.id)
  DeliveryAddress.create(name: 'mail poslovni',
                         address: 'hrvoje@posao.com',
                         delivery_service_id: mail.id,
                         consumer_id: hrvoje.id)

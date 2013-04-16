# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

  #default admin
  admin = User.create(username: 'admin', email: 'admin@admin.com', password:
              'admin', password_confirmation: 'admin')
  trexmark = User.create(username: 'trexmark', email: 'trex@mark.com', password:
              'trexmark', password_confirmation: 'trexmark')
  admin.add_role :admin
  inge_mark = Context.create(name: 'inge-mark')
  trexmark.add_role :user, inge_mark

  viktor = Consumer.create(name: 'viktor')
  alen = Consumer.create(name: 'alen')
  josip = Consumer.create(name: 'josip')


  mail = DeliveryService.create(name: 'mail')
  phone = DeliveryService.create(name: 'phone')

  DeliveryServiceProperty.create(key: 'address',
                                 value: 'mailtrap.io',
                                 delivery_service_id: mail.id)
  DeliveryServiceProperty.create(key: 'user_name',
                                 value: 'user_name',
                                 delivery_service_id: mail.id)
  DeliveryServiceProperty.create(key: 'password',
                                 value: 'password',
                                 delivery_service_id: mail.id)
  DeliveryServiceProperty.create(key: 'port',
                                 value: '2525',
                                 delivery_service_id: mail.id)
  DeliveryServiceProperty.create(key: 'authentication',
                                 value: 'plain',
                                 delivery_service_id: mail.id)
  
  Template.create(context_id: inge_mark.id,
                 delivery_service_id: mail.id,
                 field: 'subject',
                 content: 'Eskalator')

  Template.create(context_id: inge_mark.id,
                 delivery_service_id: mail.id,
                 field: 'body',
                 content: "Ovo je eskalacija.
      External reference: <%= @escalation.external_reference_id %>
      Context: <%= @escalation.subscription.escalation_level.context.name %>")

  viktor_mail = DeliveryAddress.create(name: 'viktor mail',
                                       address: 'viktor@inge-mark.hr',
                                       delivery_service_id: mail.id,
                                       consumer_id: viktor.id)
  alen_mail = DeliveryAddress.create(name: 'alen mail',
                                       address: 'alen@inge-mark.hr',
                                       delivery_service_id: mail.id,
                                       consumer_id: alen.id)
  josip_mail = DeliveryAddress.create(name: 'josip mail',
                                       address: 'josip@inge-mark.hr',
                                       delivery_service_id: mail.id,
                                       consumer_id: josip.id)

  prvi_inge_mark = EscalationLevel.create(name: 'prvi inge-mark',
                                          context_id: inge_mark.id,
                                          level: 1,
                                          when: 10,
                                          sequential_notification: false)
  drugi_inge_mark = EscalationLevel.create(name: 'drugi inge-mark',
                                          context_id: inge_mark.id,
                                          level: 2,
                                          when: 60,
                                          sequential_notification: false)

  viktor_inge_mark = Subscription.create(name: 'viktor inge-mark',
                                         escalation_level_id: drugi_inge_mark.id,
                                         delivery_address_id: viktor_mail.id,
                                         consumer_sequence: 2)
  alen_inge_mark = Subscription.create(name: 'alen inge-mark',
                                         escalation_level_id: prvi_inge_mark.id,
                                         delivery_address_id: alen_mail.id,
                                         consumer_sequence: 1)
  josip_inge_mark = Subscription.create(name: 'josip inge-mark',
                                         escalation_level_id: drugi_inge_mark.id,
                                         delivery_address_id: josip_mail.id,
                                         consumer_sequence: 1)

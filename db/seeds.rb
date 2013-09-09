# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


pages = Page.create([
  {title: 'Центр обручальных колец', url: 'wedding-rings-center'},
  {title: 'Для компаний', url: 'companies'},
  {title: 'О компании', url: 'about'},
  {title: 'Ювелирная фабрика', url: 'jewelry-factory'},
  {title: 'Учебный центр', url: 'edu-center'},
  {title: 'Сувенирная продукция', url: 'souvenirs'},
  {title: 'Дизайн-студия', url: 'design-studio'},
  {title: 'Неделя ювелирной моды', url: 'jewelry-fashion-week'},
  {title: 'Сеть магазинов', url: 'stores'},
  {title: 'Свадебная фотосессия', url: 'wedding-photo-shoot'}
])

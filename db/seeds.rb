# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Producttype.create!( name: "現貨")
Producttype.create!( name: "預購空運")
Producttype.create!( name: "預購海運")
Account.create!( :account_name => "germanysky", :name => "種馬",:sex=>"男",:email => "germanyskt@gmail.com",:role =>1 , :account_level_id => "1",:score => 0,:point =>100000)
AccountLevel.create!(level_name: "基本會員",score: 0,order_price: 0,discount: 0)